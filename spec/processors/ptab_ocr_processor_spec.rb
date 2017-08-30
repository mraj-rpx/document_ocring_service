require 'rails_helper'

RSpec.describe PtabOcrProcessor do
  describe 'constants' do
    it 'should have a constant FREQUENCY' do
      expect(PtabOcrProcessor::FREQUENCY).to eq('2m')
    end

    it 'should have a constant LIMIT' do
      expect(PtabOcrProcessor::LIMIT).to eq(5)
    end
  end

  describe 'process!' do
    let!(:ptab_doc_1) { FactoryGirl.create(:ptab_case_detail, needs_ocr: true) }

    it 'should ocr the ptab documents which are marked as needs_ocr TRUE' do
      allow_any_instance_of(S3Downloader).to receive(:download).and_return(File.join(Rails.root, 'spec/support/documents/test.pdf'))
      expect{
        PtabOcrProcessor.new.process!
        ptab_doc_1.reload
        expect(ptab_doc_1.needs_ocr).to be(false)
      }.to change{ ptab_doc_1.reload.ocr_text }
    end

    it 'should not ocr the ptab documents which are marked as needs_ocr to FALSE' do
      ptab_doc_1.update_attributes(needs_ocr: false)
      expect{
        PtabOcrProcessor.new.process!
      }.not_to change{ ptab_doc_1.reload.ocr_text }
    end

    it 'should record the ocr exception when OCR process got failed' do
      allow_any_instance_of(S3Downloader).to receive(:download).and_raise('Could not download the file')
      expect{
        PtabOcrProcessor.new.process!
      }.to change{ ptab_doc_1.reload.ocr_exception }.to('Could not download the file').from(nil)
    end
  end
end
