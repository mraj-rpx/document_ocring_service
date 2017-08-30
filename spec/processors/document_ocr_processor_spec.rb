require 'rails_helper'

RSpec.describe DocumentOcrProcessor do
  describe 'constants' do
    it 'should have a constant FREQUENCY' do
      expect(DocumentOcrProcessor::FREQUENCY).to eq('1m')
    end

    it 'should have a constant LIMIT' do
      expect(DocumentOcrProcessor::LIMIT).to eq(5)
    end
  end

  describe 'process!' do
    let!(:document_1) { FactoryGirl.create(:document, status: :todo_from_ui) }
    let!(:document_2) { FactoryGirl.create(:document, status: :todo_from_api) }

    it 'should ocr the documents which are uploaded through UI' do
      expect{
        DocumentOcrProcessor.new.process!
        document_1.reload
        expect(document_1.ocr_text).not_to be(nil)
      }.to change{document_1.reload.status}.to('completed').from('todo_from_ui')
    end

    it 'should not ocr the documents which are uploaded through API' do
      expect{
        DocumentOcrProcessor.new.process!
      }.not_to change{ document_2.reload.status }
    end

    it 'should record the error message when OCR is failed' do
      allow_any_instance_of(DocsplitProcessor).to receive(:process).and_raise('Could not ocr the file')
      expect{
        DocumentOcrProcessor.new.process!
        document_1.reload
        expect(document_1.reload.exception).to eq('Could not ocr the file')
        expect(document_1.reload.ocr_text).to be(nil)
      }.to change{document_1.reload.status}.to('failed').from('todo_from_ui')
    end

    it 'should process OCRing next document when one got failed' do
      document_3 = FactoryGirl.create(:document, status: :todo_from_ui, file: nil)

      expect {
        DocumentOcrProcessor.new.process!
        document_3.reload
        expect(document_3.status).to eq('failed')
        expect(document_3.ocr_text).to be(nil)
        expect(document_1.reload.status).to eq('completed')
      }.to change{ document_1.reload.ocr_text }
    end

    it 'should also extract the patent from the OCR text' do
      allow_any_instance_of(PatentDetailExtractor).to receive(:extract!)
      DocumentOcrProcessor.new.process!
    end
  end
end
