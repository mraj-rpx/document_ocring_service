require 'rails_helper'

RSpec.describe PatAssignmentOcrProcessor do
  describe 'constants' do
    it 'should have a constant FREQUENCY' do
      expect(PatAssignmentOcrProcessor::FREQUENCY).to eq('3m')
    end

    it 'should have a constant LIMIT' do
      expect(PatAssignmentOcrProcessor::LIMIT).to eq(5)
    end
  end

  describe 'process!' do
    before(:each) do
      allow(DocsplitProcessor).to receive(:new).and_return(DocsplitStruct.new)
      allow_any_instance_of(S3Uploader).to receive(:save_to_s3)
    end

    let!(:pat_assign_1) { FactoryGirl.create(:pat_assign) }

    it 'should ocr the pat assignment attachment documents which are marked as needs_ocr TRUE' do
      pdf_file = File.open(File.join(Rails.root, 'spec/fixtures/documents/test.pdf'))
      allow_any_instance_of(S3Downloader).to receive(:download).and_return(pdf_file)

      expect{
        PatAssignmentOcrProcessor.new.process!
        pat_assign_1.reload
        expect(pat_assign_1.s3_ocr_url).to be_present
      }.to change{ pat_assign_1.reload.s3_ocr_url }
    end

    it 'should not ocr the pat assignment attachment documents which already have s3_ocr_url' do
      pat_assign_1.update_attributes(s3_ocr_url: 'pat-assignments/abcdef/10.txt')
      expect{
        PatAssignmentOcrProcessor.new.process!
      }.not_to change{ pat_assign_1.s3_ocr_url }
    end

    it 'should record the ocr exception when OCR process got failed' do
      allow_any_instance_of(S3Downloader).to receive(:download).and_raise('Could not download the file')
      expect{
        PatAssignmentOcrProcessor.new.process!
      }.to change{ pat_assign_1.reload.ocr_exception }.to('Could not download the file').from(nil)
    end

    it 'should notify honeybadger when ocr process failed' do
      allow_any_instance_of(S3Downloader).to receive(:download).and_raise('Could not download the file')
      expect(Honeybadger).to receive(:notify) do |exception, context|
        expect(exception.message).to eq('Could not download the file')
        expect(context[:context][:document_id]).to eq(pat_assign_1.id)
        expect(context[:context][:document_type]).to eq(PatAssignmentAttachment)
      end
      expect{
        PatAssignmentOcrProcessor.new.process!
      }.to change{ pat_assign_1.reload.ocr_exception }.to('Could not download the file').from(nil)
    end
  end
end
