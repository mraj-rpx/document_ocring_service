require 'rails_helper'

RSpec.describe PatentDetailExtractor do
  describe 'constants' do
    it 'should have constant US_COUNTRY_CODE' do
      expect(PatentDetailExtractor::US_COUNTRY_CODE).to eq('US')
     end

    it 'should have constant CORE_ASSET_SOURCE' do
      expect(PatentDetailExtractor::CORE_ASSET_SOURCE).to eq('C')
    end

    it 'should have constant DOCDB_ASSET_SOURCE' do
      expect(PatentDetailExtractor::DOCDB_ASSET_SOURCE).to eq('D')
    end

    it 'should have constant MANUAL_ASSET_SOURCE' do
      expect(PatentDetailExtractor::MANUAL_ASSET_SOURCE).to eq('M')
    end

    it 'should have constant PATENT_REGEX' do
      expect(PatentDetailExtractor::PATENT_REGEX).to eq(/([A-Z]{2,})?([0-9\-]{4,})/)
    end

    it 'should have constant IMPORT_RECORDS_LIMIT' do
      expect(PatentDetailExtractor::IMPORT_RECORDS_LIMIT).to eq(250)
    end

    it 'should have constant MANUAL_SEARCHING_LEVELS' do
      levels = [:patent_number, :publication_number, :application_number].map do |col_name|
        {klass: ManualAsset, country_code: 'US', column_name: col_name, asset_source: 'M'}
      end
      expect(PatentDetailExtractor::MANUAL_SEARCHING_LEVELS).to eq(levels)
    end
  end

  describe 'extract!' do
    describe 'when US country code is prepended to patent number' do
      let!(:document_1) { FactoryGirl.create(:document, ocr_text: 'patent number is US123456') }

      it 'LEVEL_1 => should match the core.pats.stripped_patnum and country code' do
        core_pat_1 = FactoryGirl.create(:core_pat, stripped_patnum: '123456')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: core_pat_1.patnum, asset_source: 'C', asset_source_id: core_pat_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_2 => should match the core.pats.app_num_country when LEVEL_1 is failed to get match' do
        core_pat_1 = FactoryGirl.create(:core_pat, app_num_country: '123456', stripped_patnum: '12')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: core_pat_1.patnum, asset_source: 'C', asset_source_id: core_pat_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_3 => should match the acquiflow.manual_assets.patent_number when LEVEL_2 is failed to get the match' do
        manual_asset_1 = FactoryGirl.create(:manual_asset, patent_number: '123456', country_code: 'US')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: manual_asset_1.patnum, asset_source: 'M', asset_source_id: manual_asset_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_4 => should match the acquiflow.manual_assets.publication_number when LEVEL_3 is failed to get the match' do
        manual_asset_1 = FactoryGirl.create(:manual_asset, publication_number: '123456', country_code: 'US')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: manual_asset_1.patnum, asset_source: 'M', asset_source_id: manual_asset_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_5 => should match the acquiflow.manual_assets.application_number when LEVEL_4 is failed to get the match' do
        manual_asset_1 = FactoryGirl.create(:manual_asset, application_number: '123456', country_code: 'US')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: manual_asset_1.patnum, asset_source: 'M', asset_source_id: manual_asset_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'should return NO patents when all LEVELS 1-5 failed to get match' do
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([{document_name: document_1[:file], patents: []}])
      end

      it 'should not go for LEVEL_2 when LEVEL_1 is success' do
        core_pat_1 = FactoryGirl.create(:core_pat, stripped_patnum: '123456', app_num_country: '12')
        FactoryGirl.create(:core_pat, stripped_patnum: '12', app_num_country: '123456', patnum: '34')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: core_pat_1.patnum, asset_source: 'C', asset_source_id: core_pat_1.id, matched_with_country_code: true}]
          }
        ])
      end
    end

    describe 'when NON-US country code is prepended to patent number' do
      let!(:document_1) { FactoryGirl.create(:document, ocr_text: 'patent number is AU123456') }

      it 'LEVEL_1 => should match docdb.docdb_pats.stripped_patnum' do
        docdb_pat_1 = FactoryGirl.create(:docdb_pat, stripped_patnum: '123456')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: docdb_pat_1.patnum, asset_source: 'D', asset_source_id: docdb_pat_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_2 => should match the docdb.docdb_pats.app_num_intl when STEP_1 is failed to get match' do
        docdb_pat_1 = FactoryGirl.create(:docdb_pat, stripped_patnum: '123456')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: docdb_pat_1.patnum, asset_source: 'D', asset_source_id: docdb_pat_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_3 => should match the acquiflow.manual_assets.patent_number when LEVEL_2 is failed to get the match' do
        manual_asset_1 = FactoryGirl.create(:manual_asset, patent_number: '123456', country_code: 'AU')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: manual_asset_1.patnum, asset_source: 'M', asset_source_id: manual_asset_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_4 => should match the acquiflow.manual_assets.publication_number when LEVEL_3 is failed to get the match' do
        manual_asset_1 = FactoryGirl.create(:manual_asset, publication_number: '123456', country_code: 'AU')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: manual_asset_1.patnum, asset_source: 'M', asset_source_id: manual_asset_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'LEVEL_5 => should match the acquiflow.manual_assets.application_number when LEVEL_4 is failed to get the match' do
        manual_asset_1 = FactoryGirl.create(:manual_asset, application_number: '123456', country_code: 'AU')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [{patnum: manual_asset_1.patnum, asset_source: 'M', asset_source_id: manual_asset_1.id, matched_with_country_code: true}]
          }
        ])
      end

      it 'should return NO patents when all LEVELS 1-5 failed to get match' do
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([{document_name: document_1[:file], patents: []}])
      end

      it 'should match the both docdb and manual asset LEVEL_1 & LEVEL_5' do
        docdb_pat_1 = FactoryGirl.create(:docdb_pat, stripped_patnum: '123456', country_code: 'AB')
        manual_asset_1 = FactoryGirl.create(:manual_asset, application_number: '56789', country_code: 'AU')

        document_1.update_attributes(ocr_text: 'Patent number is AB123456 and AU56789')
        patents = PatentDetailExtractor.new([document_1]).extract!
        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [
              {patnum: docdb_pat_1.patnum, asset_source: 'D', asset_source_id: docdb_pat_1.id, matched_with_country_code: true},
              {patnum: manual_asset_1.patnum, asset_source: 'M', asset_source_id: manual_asset_1.id, matched_with_country_code: true}
            ]
          }
        ])
      end
    end

    describe 'when country code is not prepended to patent number' do
      let!(:document_1) { FactoryGirl.create(:document, ocr_text: 'Patent nums 123456') }

      it 'LEVEL_1 => should match the patent number from both core.pats.stripped_patnum and docdb_pats.stripped_patnum' do
        core_pat_1 = FactoryGirl.create(:core_pat, stripped_patnum: '123456', country_code: 'US')
        docdb_pat_1 = FactoryGirl.create(:docdb_pat, stripped_patnum: '123456', country_code: 'AU')
        patents = PatentDetailExtractor.new([document_1]).extract!

        expect(patents).to eq([
          {
            document_name: document_1[:file],
            patents: [
              {patnum: core_pat_1.patnum, asset_source: 'C', asset_source_id: core_pat_1.id, matched_with_country_code: false},
              {patnum: docdb_pat_1.patnum, asset_source: 'D', asset_source_id: docdb_pat_1.id, matched_with_country_code: false}
            ]
          }
        ])
      end
    end
  end
end
