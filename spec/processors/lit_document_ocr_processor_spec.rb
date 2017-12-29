require 'rails_helper'

RSpec.describe LitDocumentOcrProcessor do
  describe 'constants' do
    it 'should have a constant FREQUENCY' do
      expect(LitDocumentOcrProcessor::FREQUENCY).to eq('2m')
    end

    it 'should have a constant LIMIT' do
      expect(PtabOcrProcessor::LIMIT).to eq(5)
    end
  end

  describe 'process!' do
    before(:each) do
      allow(DocsplitProcessor).to receive(:new).and_return(DocsplitStruct.new)
      allow_any_instance_of(S3Uploader).to receive(:save_to_s3)
    end

    let!(:lit_doc_1) { FactoryGirl.create(:lit_document, needs_ocr: true, document_status_id: 3) }

    it 'should ocr the lit documents which are marked as needs_ocr TRUE' do
      pdf_file = File.open(File.join(Rails.root, 'spec/fixtures/documents/test.pdf'))
      allow_any_instance_of(S3Downloader).to receive(:download).and_return(pdf_file)

      expect{
        LitDocumentOcrProcessor.new.process!
        lit_doc_1.reload
        expect(lit_doc_1.needs_ocr).to be(false)
        expect(lit_doc_1.ocr_text).to eq('Text struct')
        expect(lit_doc_1.ocr_text_s3_path).to be_present
      }.to change{ lit_doc_1.reload.ocr_text }
    end

    it 'should not ocr the ptab documents which are marked as needs_ocr to FALSE' do
      lit_doc_1.update_attributes(needs_ocr: false)
      expect{
        LitDocumentOcrProcessor.new.process!
      }.not_to change{ lit_doc_1.reload.ocr_text }
    end

    it 'should record the ocr exception when OCR process got failed' do
      allow_any_instance_of(S3Downloader).to receive(:download).and_raise('Could not download the file')
      expect{
        LitDocumentOcrProcessor.new.process!
      }.to change{ lit_doc_1.reload.ocr_exception }.to('Could not download the file').from(nil)
    end
  end
end
