require 'rails_helper'

RSpec.describe OCRProcessor do
  describe 'constants' do
    it 'should have a constant PROCESSOR_LIST' do
      expect(OCRProcessor::PROCESSOR_LIST).to eq([DocumentOcrProcessor, PtabOcrProcessor, LitDocumentOcrProcessor,
                                                  PatAssignmentOcrProcessor, PatAssignmentMetadataProcessor,
                                                  LitDocumentOngoingOcrProcessor, LitDocumentBackfillOcrProcessor,
                                                  PtabBackfillOcrProcessor, AppDataOcrProcessor])
    end
  end

  describe 'schedule_ocr!' do
    let!(:ocr_processor) { OCRProcessor.new.schedule_ocr! }

    it 'should return the scheduler' do
      expect(ocr_processor).to be_a(Rufus::Scheduler)
    end

    it 'should schedule the OCR cron for PTAB case documents' do
      ptab_scheduler = ocr_processor.jobs[1]
      expect(ptab_scheduler.opts[:tag]).to eq ('PtabOcrProcessor')
      expect(ptab_scheduler.original).to eq ('2m')
    end

    it 'should schedule the OCR cron for custom documents' do
      ptab_scheduler = ocr_processor.jobs[0]
      expect(ptab_scheduler.opts[:tag]).to eq ('DocumentOcrProcessor')
      expect(ptab_scheduler.original).to eq ('1m')
    end

    it 'should schedule the OCR cron for litigation documents' do
      ptab_scheduler = ocr_processor.jobs[2]
      expect(ptab_scheduler.opts[:tag]).to eq ('LitDocumentOcrProcessor')
      expect(ptab_scheduler.original).to eq ('2m')
    end

    it 'should schedule the OCR cron for patent assignment attachment documents' do
      ptab_scheduler = ocr_processor.jobs[3]
      expect(ptab_scheduler.opts[:tag]).to eq ('PatAssignmentOcrProcessor')
      expect(ptab_scheduler.original).to eq ('3m')
    end

    it 'should schedule the patent assignment metadata extractor' do
      ptab_scheduler = ocr_processor.jobs[4]
      expect(ptab_scheduler.opts[:tag]).to eq ('PatAssignmentMetadataProcessor')
      expect(ptab_scheduler.original).to eq ('3m')
    end
  end
end
