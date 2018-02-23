# coding: utf-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171205073322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "adminpack"
  enable_extension "btree_gist"
  enable_extension "dblink"
  enable_extension "file_fdw"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "insert_username"
  enable_extension "intarray"
  enable_extension "pg_buffercache"
  enable_extension "pg_freespacemap"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  # enable_extension "pglogical"

  create_table "account2product__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "account__c", limit: 18
    t.string "product_or_service__c", limit: 18
    t.text "relevantproducts__c"
    t.string "does_not_care__c", limit: 5
    t.decimal "revenue_estimate__c", precision: 24, scale: 6
    t.string "tier__c", limit: 255
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at"
    t.index ["account__c", "product_or_service__c"], name: "account2product_acct_prdct_idx"
    t.index ["id"], name: "uaccount2product__c", unique: true
    t.index ["product_or_service__c"], name: "idx_account2product_product_or_service"
  end

  create_table "account_merge_delete__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 80
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "account_id__c", limit: 18
    t.string "account_name__c", limit: 255
    t.string "action_type__c", limit: 255
    t.decimal "entity_id__c", precision: 18
    t.string "master_account_name__c", limit: 255
    t.decimal "master_entity_id__c", precision: 18
    t.string "master_rpx_account_id__c", limit: 255
    t.string "merged_to_account_id__c", limit: 18
    t.string "rpx_account_id__c", limit: 255
    t.index ["id"], name: "uaccount_merge_delete__c", unique: true
  end

  create_table "accounts_with_claim_charts", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "acquisitionopportunity", limit: 18
    t.string "accountx", limit: 18
    t.string "claim_chart_note", limit: 765
    t.string "core_claim_charted_company_id", limit: 150
    t.string "patent__c", limit: 18
    t.index ["id"], name: "uaccounts_with_claim_charts", unique: true
  end

  create_table "accountx", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "masterrecordid", limit: 18
    t.string "namex", limit: 765
    t.string "typex", limit: 255
    t.string "recordtypeid", limit: 18
    t.string "parentid", limit: 18
    t.string "billingstreet", limit: 765
    t.string "billingcity", limit: 120
    t.string "billingstate", limit: 60
    t.string "billingpostalcode", limit: 60
    t.string "billingcountry", limit: 120
    t.string "shippingstreet", limit: 765
    t.string "shippingcity", limit: 120
    t.string "shippingstate", limit: 60
    t.string "shippingpostalcode", limit: 60
    t.string "shippingcountry", limit: 120
    t.string "phone", limit: 120
    t.string "fax", limit: 120
    t.string "accountnumber", limit: 120
    t.string "website", limit: 765
    t.string "sic", limit: 60
    t.string "industry", limit: 255
    t.decimal "annualrevenue", precision: 24, scale: 6
    t.decimal "numberofemployees"
    t.string "ownership", limit: 255
    t.string "tickersymbol", limit: 60
    t.text "description"
    t.string "rating", limit: 255
    t.string "site", limit: 240
    t.string "currencyisocode", limit: 255
    t.string "ownerid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.string "are_we_under_nda__c", limit: 5
    t.datetime "nda_signing_date__c"
    t.datetime "nda_expiry_date__c"
    t.decimal "rpx_rate__c", precision: 18
    t.string "financial_data_source__c", limit: 450
    t.decimal "operating_income_y1__c", precision: 24, scale: 6
    t.decimal "operating_income_y2__c", precision: 24, scale: 6
    t.decimal "operating_income_y3__c", precision: 24, scale: 6
    t.decimal "normalized_operating_income__c", precision: 21, scale: 6
    t.datetime "membership_start_date__c"
    t.datetime "membership_expiration_date__c"
    t.string "import_reference__c", limit: 150
    t.text "industry__c"
    t.string "rate_comments__c", limit: 765
    t.decimal "opportunities_count__c", precision: 18
    t.datetime "fiscal_year_close__c"
    t.string "d_u_n_s__c", limit: 60
    t.string "npe__c", limit: 12
    t.decimal "no_of_litigation_opportunities", precision: 18
    t.string "rpx_account_id__c", limit: 90
    t.string "top_prospect_list__c", limit: 255
    t.string "applicable_rate_card__c", limit: 255
    t.decimal "rpx_rcrate__c", precision: 18, scale: 3
    t.string "primary_market_sector__c", limit: 255
    t.decimal "applicable_segment_revenue__c", precision: 24, scale: 6
    t.string "publicity__c", limit: 255
    t.string "secondary_market_sector__c", limit: 255
    t.string "tertiary_market_sector__c", limit: 255
    t.string "ultimate_parent_account__c", limit: 18
    t.text "notes__c"
    t.string "size__c", limit: 255
    t.string "tier__c", limit: 255
    t.string "fin_serv_market_sector_detail", limit: 255
    t.string "lid__linkedin_company_id__c", limit: 240
    t.datetime "rate_last_updated__c"
    t.decimal "applicable_segment_revenue_man", precision: 24, scale: 6
    t.string "financial_data_source_type__c", limit: 255
    t.datetime "fiscal_year_close_manual__c"
    t.datetime "fiscal_year_close_thomson__c"
    t.decimal "operating_income_y1_manual__c", precision: 24, scale: 6
    t.decimal "operating_income_y1_thomson__c", precision: 24, scale: 6
    t.decimal "operating_income_y2_manual__c", precision: 24, scale: 6
    t.decimal "operating_income_y2_thomson__c", precision: 24, scale: 6
    t.decimal "operating_income_y3_manual__c", precision: 24, scale: 6
    t.decimal "operating_income_y3_thomson__c", precision: 24, scale: 6
    t.string "rate_comments_manual__c", limit: 765
    t.string "rate_comments_thomson__c", limit: 765
    t.datetime "rate_last_updated_manual__c"
    t.datetime "rate_last_updated_thomson__c"
    t.decimal "revenue_current_year_manual__c", precision: 24, scale: 6
    t.decimal "revenue_current_year_thomson", precision: 24, scale: 6
    t.string "rate_last_updated_by_manual__c", limit: 765
    t.string "rate_last_update_by__c", limit: 60
    t.string "workflow_trigger__c", limit: 5
    t.string "membership_announced__c", limit: 5
    t.string "show_membership_status__c", limit: 5
    t.decimal "entity_id__c", precision: 18
    t.text "ultimate_parent__c"
    t.string "contract_term__c", limit: 255
    t.string "copy_shipping_address_to_billi", limit: 5
    t.string "heatmapcolor__c", limit: 255
    t.string "mcm_entity_id__c", limit: 30
    t.string "nda_notes__c", limit: 765
    t.string "recordtypename__c", limit: 765
    t.datetime "renewaldate__c"
    t.datetime "startdate__c"
    t.decimal "lits_filed_2_years_ago__c", precision: 18
    t.decimal "lits_filed_3_years_ago__c", precision: 18
    t.decimal "lits_filed_4_years_ago__c", precision: 18
    t.decimal "lits_filed_5_years_ago__c", precision: 18
    t.decimal "lits_filed_last_years__c", precision: 18
    t.decimal "lits_filed_this_calendar_years", precision: 18
    t.decimal "lits_filed_within_last_5_years", precision: 18
    t.decimal "lits_filed_within_last_5_year0", precision: 18
    t.string "entity_core_name__c", limit: 765
    t.text "is_ult_parent_entity__c"
    t.string "ultimate_parent_entity_core_na", limit: 765
    t.decimal "ultimate_parent_entity_id__c", precision: 18
    t.text "sfdc_core_name_match__c"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "insurance_opp__c", limit: 5
    t.text "all_subs_rolling_up_here_color"
    t.string "all_subs_rolling_up_here__c", limit: 3
    t.string "core_ultimate_parent_id__c", limit: 54
    t.string "core_ultimate_parent_name__c", limit: 765
    t.decimal "count__c", precision: 18
    t.text "is_ultimate_parent_entity_colo"
    t.string "refresh__c", limit: 5
    t.text "rolled_up_accounts__c"
    t.text "sfdc_core_name_match_color__c"
    t.string "sfdc_core_name_similar__c", limit: 3
    t.text "sfdc_ultimate_parent_id__c"
    t.text "subs_not_rolling_up_here__c"
    t.string "type2__c", limit: 150
    t.text "ultimate_parent_entity_account"
    t.text "ultimate_parent_ids_match_colo"
    t.string "ultimate_parent_ids_match__c", limit: 3
    t.string "refresh_from_core__c", limit: 5
    t.string "priority__c", limit: 30
    t.string "t2012__c", limit: 5
    t.decimal "risk_based_price_not_in_000_s", precision: 16, scale: 6
    t.datetime "risk_based_price_expiration_da"
    t.string "risk_based_price_comments__c", limit: 765
    t.datetime "risk_based_price_last_updated"
    t.string "risk_based_price_last_update0", limit: 90
    t.decimal "standard_2013_in_000_s__c", precision: 18, scale: 3
    t.string "primary_patent_analyst__c", limit: 18
    t.string "dunsnumber", limit: 27
    t.string "yearstarted", limit: 12
    t.string "client_portal_view__c", limit: 255
    t.decimal "account_priority__c", precision: 1
    t.decimal "prospect_score__c", precision: 5
    t.decimal "priority_tier__c", precision: 1
    t.string "insurance_type__c", limit: 255
    t.decimal "current_quarter_prospect_score", precision: 5
    t.decimal "previous_quarter_prospect_scoz", precision: 5
    t.decimal "previous_quarter_prospect_scor", precision: 5
    t.decimal "standard_2014_rate_in_000_s__c", precision: 18, scale: 3
    t.string "sector_representative__c", limit: 18
    t.decimal "has_ecosystem__c", precision: 18
    t.datetime "lastvieweddate"
    t.string "tier_type__c", limit: 255
    t.string "iscustomerportal", limit: 5
    t.string "est_rate_floor__c", limit: 765
    t.datetime "est_rate_floor_last_modified"
    t.string "ins_broker_status__c", limit: 255
    t.string "region__c", limit: 255
    t.text "next_step__c"
    t.string "broker_intro_meeting_held__c", limit: 5
    t.string "broker_intro_pack_delivered__c", limit: 5
    t.string "broker_product_review_meeting", limit: 5
    t.string "broker_review_pack_delivered", limit: 5
    t.string "retail_broker_agreement_signed", limit: 5
    t.datetime "retail_broker_agreement_signe0"
    t.decimal "standard_2015_rate_in_000_s__c", precision: 18, scale: 3
    t.decimal "applications_currently_pending", precision: 18
    t.decimal "applications_completed__c", precision: 18
    t.decimal "policies_placed__c", precision: 18
    t.decimal "cumulative_bookings__c", precision: 18
    t.decimal "pricing_indications_pending__c", precision: 18
    t.decimal "broker_meetings_pending__c", precision: 18
    t.string "nda_level__c", limit: 255
    t.text "billingaddress"
    t.text "shippingaddress"
    t.string "secondary_patent_analyst__c", limit: 18
    t.string "tertiary_patent_analyst__c", limit: 18
    t.string "pasp_level__c", limit: 50
    t.boolean "active_options__c"
    t.index ["entity_id__c"], name: "idx_accountx_entity_id__c"
    t.index ["id"], name: "uaccountx", unique: true
    t.index ["rpx_account_id__c"], name: "accountx_rpx_account_id__c_idx", unique: true
  end

  create_table "acq_1016_asset_updates", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "abandoned"
    t.string "disc_number"
    t.string "country_code"
    t.string "application_number"
    t.string "stripped_patnum"
    t.string "status"
    t.string "sub_status"
    t.date "sub_status_date"
    t.date "filed_date"
    t.date "issue_date"
    t.date "expiry_date"
    t.string "assignee"
    t.string "full_disc_number"
    t.string "title"
    t.string "inventors"
    t.string "stripped_patnum_updated"
    t.string "application_number_updated"
  end

  create_table "acq_counter_party_temp", id: false, force: :cascade do |t|
    t.float "acquisition_id"
    t.text "seller_sf_account_name"
    t.text "seller_sf_account_id"
    t.float "counter_party_type_id"
    t.text "counter_party_type_name"
  end

  create_table "acquisition_agreements", id: :serial, force: :cascade do |t|
    t.integer "acquisition_id", null: false
    t.integer "agreement_term_id"
    t.string "fee"
    t.boolean "license_back"
    t.string "seller_sf_account_id"
    t.string "notes"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "acquisition_agreements_agreement_types", id: :serial, force: :cascade do |t|
    t.integer "acquisition_agreement_id", null: false
    t.integer "agreement_type_id", null: false
    t.index ["acquisition_agreement_id", "agreement_type_id"], name: "acquisition_agreements_agreem_acquisition_agreement_id_agre_idx", unique: true
  end

  create_table "acquisition_encumbrance_patents", id: false, force: :cascade do |t|
    t.integer "acquisition_encumbrance_id", null: false
    t.integer "acquisition_patent_id", null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.serial "id", null: false
  end

  create_table "acquisition_encumbrances", id: :serial, force: :cascade do |t|
    t.integer "acquisition_id", null: false
    t.integer "encumbrance_type_id", null: false
    t.string "entity_sf_account_id"
    t.string "notes"
    t.boolean "all_patents"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.date "start_date"
    t.date "end_date"
  end

  create_table "acquisition_market_sector_det", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "acquisition__c", limit: 18
    t.string "market_sector_detail__c", limit: 18
    t.string "cd_priority__c", limit: 9
    t.string "notes__c", limit: 765
    t.index ["id"], name: "uacquisition_market_sector_det", unique: true
  end

  create_table "acquisition_opportunities_portfolios", id: :serial, force: :cascade do |t|
    t.integer "portfolio_id", null: false
    t.string "acquisition_sf_id", limit: 64, null: false
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "acquisition_opportunity__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.string "recordtypeid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.text "accountid__c"
    t.string "account__c", limit: 18
    t.string "action_item_assigned_to__c", limit: 150
    t.decimal "amount_for_pipeline__c", precision: 22, scale: 6
    t.string "analysis_assigned_to__c", limit: 18
    t.datetime "analysis_completed__c"
    t.text "analysis_next_steps__c"
    t.text "analysis_notes__c"
    t.text "analysis_recommendation__c"
    t.string "analysis_requested__c", limit: 5
    t.string "analysis_stage__c", limit: 255
    t.datetime "analysis_start_date__c"
    t.text "analysis_explanation__c"
    t.string "best_patent_s__c", limit: 765
    t.datetime "bids_due__c"
    t.decimal "brokersopeningoffer__c", precision: 22, scale: 6
    t.string "campaign__c", limit: 18
    t.text "characterization_of_claims__c"
    t.string "claims_previously_held_invalid", limit: 5
    t.string "claims_charts_provided__c", limit: 765
    t.string "clonedfrom__c", limit: 18
    t.datetime "closedate__c"
    t.text "close_quarter__c"
    t.string "closed_lost_primary_reason_lit", limit: 255
    t.text "closed_lost_secondary_reason_l"
    t.text "comments__c"
    t.string "relevant_industries__c", limit: 765
    t.string "confidentiality_level__c", limit: 255
    t.string "contact1__c", limit: 18
    t.datetime "contracteffectivedate__c"
    t.string "current_status_sa__c", limit: 765
    t.text "current_status__c"
    t.text "deal_notes__c"
    t.string "deal_probability__c", limit: 255
    t.text "deal_summary__c"
    t.string "degree_of_dialogue__c", limit: 255
    t.text "description__c"
    t.text "detection__c"
    t.datetime "due_date__c"
    t.datetime "earliest_priority__c"
    t.text "enforcement_review__c"
    t.text "executive_summary__c"
    t.datetime "expiration_date__c"
    t.text "file_history_review__c"
    t.string "forecastcategoryname__c", limit: 255
    t.datetime "free_option_expiration_date__c"
    t.string "free_option_notes__c", limit: 765
    t.decimal "free_options_negotiated__c", precision: 16
    t.decimal "free_options_remaining__c", precision: 18
    t.decimal "free_options_used__c", precision: 16
    t.string "isprivate__c", limit: 5
    t.text "key_claim_s__c"
    t.text "key_patent_s_and_claims__c"
    t.text "last_action__c"
    t.string "leadsource__c", limit: 255
    t.string "legacyopportunityid__c", limit: 54
    t.text "legal_notes__c"
    t.string "licensee_scratchpad__c", limit: 765
    t.text "licensing_and_ownership_histor"
    t.text "litigation_forecast__c"
    t.string "litigation_history__c", limit: 765
    t.string "nda__c", limit: 5
    t.string "nextstep__c", limit: 765
    t.decimal "no_of_non_us_applications_inpu", precision: 18
    t.decimal "no_of_non_us_applications_roll", precision: 18
    t.decimal "no_of_non_us_patents_input__c", precision: 10
    t.decimal "no_of_non_us_patents_roll_up", precision: 18
    t.decimal "no_of_us_applications_input__c", precision: 10
    t.decimal "no_of_us_applications_roll_up", precision: 18
    t.decimal "no_of_us_patents_roll_up__c", precision: 18
    t.text "non_us_patent_application__c"
    t.text "non_us_patent_numbers__c"
    t.text "notes__c"
    t.text "other_research_notes__c"
    t.text "outside_expert_analysis__c"
    t.text "patent_portfolio_summary__c"
    t.string "patents_in_suit__c", limit: 18
    t.text "phase_0_comments__c"
    t.text "portfolio_patents__c"
    t.string "previous_analysis_notes__c", limit: 765
    t.string "primary_market_sector__c", limit: 255
    t.text "priority_research__c"
    t.string "priority__c", limit: 255
    t.text "private_deal_notes__c"
    t.string "probability__c", limit: 255
    t.text "prospect_member_notes__c"
    t.datetime "purchase_date__c"
    t.string "quarter__c", limit: 255
    t.string "quick_opinion__c", limit: 255
    t.string "quick_recommendation__c", limit: 255
    t.string "rpx_opportunityid__c", limit: 90
    t.decimal "rpxsopeningoffer__c", precision: 22, scale: 6
    t.text "record_type_text__c"
    t.string "rejected_deal_primary_reason", limit: 255
    t.text "rejected_deal_secondary_reason"
    t.string "report_toggle__c", limit: 5
    t.text "representative_claims__c"
    t.text "sme_review__c"
    t.decimal "scariness__c", precision: 18
    t.string "seller_loop_closed__c", limit: 5
    t.text "seller_notes__c"
    t.text "seller_research__c"
    t.string "seller_claims_charts__c", limit: 5
    t.string "sellersexplicitexpectation__c", limit: 300
    t.string "send_update_notifications__c", limit: 255
    t.string "source__c", limit: 18
    t.text "spec_support__c"
    t.string "stagename__c", limit: 255
    t.datetime "start_date__c"
    t.string "suit_ranking__c", limit: 255
    t.text "summary__c"
    t.datetime "summary_fields_updated__c"
    t.text "technology_area__c"
    t.text "theories_of_relevance__c"
    t.decimal "totalopportunityquantity__c", precision: 18, scale: 2
    t.text "triage_comments__c"
    t.string "type__c", limit: 255
    t.text "us_application_numbers__c"
    t.string "verbose_notifications__c", limit: 255
    t.decimal "who_cares__c", precision: 18
    t.string "rpx_project_code__c", limit: 90
    t.decimal "no_of_us_patents__c", precision: 18
    t.text "legacy_broadest_independent_cl"
    t.text "legacy_characterization_of_cla"
    t.text "legacy_confidential_working_no"
    t.text "legacy_summary__c"
    t.text "assigned_analyst_is_current_us"
    t.string "rights_type__c", limit: 255
    t.datetime "date_filter__c"
    t.string "of_patents_manual_entry__c", limit: 120
    t.string "asset_source_type__c", limit: 255
    t.datetime "public_deal_notes_updated_by_a"
    t.datetime "last_action_updated_by_acq__c"
    t.datetime "next_step_updated_by_acq__c"
    t.datetime "seller_s_expectation_updated_b"
    t.datetime "last_significant_update_by_acq"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.decimal "count__c", precision: 18
    t.decimal "n_defendants_active__c", precision: 18
    t.decimal "n_defendants_terminated__c", precision: 18
    t.decimal "n_defendants__c", precision: 18
    t.decimal "n_members_active__c", precision: 18
    t.decimal "n_members_terminated__c", precision: 18
    t.decimal "n_members__c", precision: 18
    t.decimal "n_prospects_active__c", precision: 18
    t.decimal "n_prospects_terminated__c", precision: 18
    t.decimal "n_prospects__c", precision: 18
    t.string "refresh__c", limit: 5
    t.string "member_credit_portfolio_descri", limit: 300
    t.string "deal_team_1__c", limit: 18
    t.string "deal_team_2__c", limit: 18
    t.string "deal_team_3__c", limit: 18
    t.string "cr_cd_action_items__c", limit: 765
    t.string "potential_rpx_benefit__c", limit: 765
    t.string "npe_offer__c", limit: 5
    t.string "asset_owner__c", limit: 18
    t.text "marketing_bullets__c"
    t.string "patent_ncs__c", limit: 255
    t.text "days_since_next_step_updated"
    t.string "acquisition_name__c", limit: 240
    t.text "comparables__c"
    t.string "notice_waiver__c", limit: 5
    t.string "name_copy_unique__c", limit: 240
    t.string "direct_notice_waiver__c", limit: 5
    t.string "color_code__c", limit: 3
    t.text "pa_documents_reviewed__c"
    t.string "sector_representative__c", limit: 18
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.decimal "no_of_non_party_entity_records", precision: 18
    t.decimal "no_of_non_party_entity_record0", precision: 18
    t.decimal "no_of_non_party_entity_record1", precision: 18
    t.decimal "no_of_non_party_entity_record2", precision: 18
    t.string "most_recent_valuation_tracking", limit: 18
    t.datetime "valuation_date__c"
    t.string "intent_to_litigate__c", limit: 5
    t.datetime "nda_expiration_date__c"
    t.string "fee__c", limit: 5
    t.string "timeline__c", limit: 765
    t.string "hold_reasons__c", limit: 255
    t.string "seller_s_expectation_an_estima", limit: 5
    t.string "most_recent_valuation_trackin0", limit: 18
    t.datetime "valuation_date_guidance__c"
    t.string "new_net_revenue_gross_margin_e", limit: 60
    t.string "insight_id__c", limit: 240
    t.datetime "insight_updated_time__c"
    t.text "amount_for_pipeline_notes__c"
    t.text "seller_s_explicit_expectation"
    t.string "brief_technology_description", limit: 255
    t.string "validity_notes__c", limit: 140
    t.string "most_recent_valuation_trackin1", limit: 18
    t.datetime "valuation_date_bid__c"
    t.index ["account__c"], name: "idx_acquisition_opportunity__c_account"
    t.index ["id"], name: "uacquisition_opportunity__c", unique: true
  end

  create_table "acquisition_opportunity__c_ds_4715_bkp", id: false, force: :cascade do |t|
    t.integer "etl_id"
    t.string "delete_flag", limit: 1
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.string "recordtypeid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.text "accountid__c"
    t.string "account__c", limit: 18
    t.string "action_item_assigned_to__c", limit: 150
    t.decimal "amount_for_pipeline__c", precision: 22, scale: 6
    t.string "analysis_assigned_to__c", limit: 18
    t.datetime "analysis_completed__c"
    t.text "analysis_next_steps__c"
    t.text "analysis_notes__c"
    t.text "analysis_recommendation__c"
    t.string "analysis_requested__c", limit: 5
    t.string "analysis_stage__c", limit: 255
    t.datetime "analysis_start_date__c"
    t.text "analysis_explanation__c"
    t.string "assets__c", limit: 18
    t.string "best_patent_s__c", limit: 765
    t.datetime "bids_due__c"
    t.decimal "brokersopeningoffer__c", precision: 22, scale: 6
    t.string "campaign__c", limit: 18
    t.text "characterization_of_claims__c"
    t.string "claims_previously_held_invalid", limit: 5
    t.string "claims_charts_provided__c", limit: 765
    t.string "clonedfrom__c", limit: 18
    t.datetime "closedate__c"
    t.text "close_quarter__c"
    t.string "closed_lost_primary_reason_lit", limit: 255
    t.text "closed_lost_secondary_reason_l"
    t.text "comments__c"
    t.string "relevant_industries__c", limit: 765
    t.string "confidentiality_level__c", limit: 255
    t.string "contact1__c", limit: 18
    t.datetime "contracteffectivedate__c"
    t.string "current_status_sa__c", limit: 765
    t.text "current_status__c"
    t.text "deal_notes__c"
    t.string "deal_probability__c", limit: 255
    t.text "deal_summary__c"
    t.string "degree_of_dialogue__c", limit: 255
    t.text "description__c"
    t.text "detection__c"
    t.datetime "due_date__c"
    t.datetime "earliest_priority__c"
    t.text "enforcement_review__c"
    t.text "executive_summary__c"
    t.datetime "expiration_date__c"
    t.text "file_history_review__c"
    t.string "forecastcategoryname__c", limit: 255
    t.datetime "free_option_expiration_date__c"
    t.string "free_option_notes__c", limit: 765
    t.decimal "free_options_negotiated__c", precision: 16
    t.decimal "free_options_remaining__c", precision: 18
    t.decimal "free_options_used__c", precision: 16
    t.string "isprivate__c", limit: 5
    t.text "key_claim_s__c"
    t.text "key_patent_s_and_claims__c"
    t.text "last_action__c"
    t.string "leadsource__c", limit: 255
    t.string "legacyopportunityid__c", limit: 54
    t.text "legal_notes__c"
    t.string "licensee_scratchpad__c", limit: 765
    t.text "licensing_and_ownership_histor"
    t.text "litigation_forecast__c"
    t.string "litigation_history__c", limit: 765
    t.string "litigation__c", limit: 18
    t.string "nda__c", limit: 5
    t.string "nextstep__c", limit: 765
    t.decimal "no_of_non_us_applications_inpu", precision: 18
    t.decimal "no_of_non_us_applications_roll", precision: 18
    t.decimal "no_of_non_us_patents_input__c", precision: 10
    t.decimal "no_of_non_us_patents_roll_up", precision: 18
    t.decimal "no_of_us_applications_input__c", precision: 10
    t.decimal "no_of_us_applications_roll_up", precision: 18
    t.decimal "no_of_us_patents_roll_up__c", precision: 18
    t.text "non_us_patent_application__c"
    t.text "non_us_patent_numbers__c"
    t.text "notes__c"
    t.text "other_research_notes__c"
    t.text "outside_expert_analysis__c"
    t.text "patent_portfolio_summary__c"
    t.string "patents_in_suit__c", limit: 18
    t.text "phase_0_comments__c"
    t.text "portfolio_patents__c"
    t.string "previous_analysis_notes__c", limit: 765
    t.string "primary_market_sector__c", limit: 255
    t.text "priority_research__c"
    t.string "priority__c", limit: 255
    t.text "private_deal_notes__c"
    t.string "probability__c", limit: 255
    t.text "prospect_member_notes__c"
    t.datetime "purchase_date__c"
    t.string "quarter__c", limit: 255
    t.string "quick_opinion__c", limit: 255
    t.string "quick_recommendation__c", limit: 255
    t.string "rpx_opportunityid__c", limit: 90
    t.decimal "rpxsopeningoffer__c", precision: 22, scale: 6
    t.text "record_type_text__c"
    t.string "rejected_deal_primary_reason", limit: 255
    t.text "rejected_deal_secondary_reason"
    t.string "report_toggle__c", limit: 5
    t.text "representative_claims__c"
    t.text "sme_review__c"
    t.decimal "scariness__c", precision: 18
    t.string "seller_loop_closed__c", limit: 5
    t.text "seller_notes__c"
    t.text "seller_research__c"
    t.string "seller_claims_charts__c", limit: 5
    t.string "sellersexplicitexpectation__c", limit: 300
    t.string "send_update_notifications__c", limit: 255
    t.string "source__c", limit: 18
    t.text "spec_support__c"
    t.string "stagename__c", limit: 255
    t.datetime "start_date__c"
    t.string "suit_ranking__c", limit: 255
    t.text "summary__c"
    t.datetime "summary_fields_updated__c"
    t.text "technology_area__c"
    t.text "theories_of_relevance__c"
    t.decimal "totalopportunityquantity__c", precision: 18, scale: 2
    t.text "triage_comments__c"
    t.string "type__c", limit: 255
    t.text "us_application_numbers__c"
    t.string "verbose_notifications__c", limit: 255
    t.decimal "who_cares__c", precision: 18
    t.string "rpx_project_code__c", limit: 90
    t.decimal "no_of_us_patents__c", precision: 18
    t.text "legacy_broadest_independent_cl"
    t.text "legacy_characterization_of_cla"
    t.text "legacy_confidential_working_no"
    t.text "legacy_summary__c"
    t.text "assigned_analyst_is_current_us"
    t.string "rights_type__c", limit: 255
    t.datetime "date_filter__c"
    t.string "of_patents_manual_entry__c", limit: 120
    t.string "asset_source_type__c", limit: 255
    t.datetime "public_deal_notes_updated_by_a"
    t.datetime "last_action_updated_by_acq__c"
    t.datetime "next_step_updated_by_acq__c"
    t.datetime "seller_s_expectation_updated_b"
    t.datetime "last_significant_update_by_acq"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.decimal "count__c", precision: 18
    t.decimal "n_defendants_active__c", precision: 18
    t.decimal "n_defendants_terminated__c", precision: 18
    t.decimal "n_defendants__c", precision: 18
    t.decimal "n_members_active__c", precision: 18
    t.decimal "n_members_terminated__c", precision: 18
    t.decimal "n_members__c", precision: 18
    t.decimal "n_prospects_active__c", precision: 18
    t.decimal "n_prospects_terminated__c", precision: 18
    t.decimal "n_prospects__c", precision: 18
    t.string "refresh__c", limit: 5
    t.string "member_credit_portfolio_descri", limit: 300
    t.string "deal_team_1__c", limit: 18
    t.string "deal_team_2__c", limit: 18
    t.string "deal_team_3__c", limit: 18
    t.string "cr_cd_action_items__c", limit: 765
    t.string "potential_rpx_benefit__c", limit: 765
    t.string "npe_offer__c", limit: 5
    t.string "asset_owner__c", limit: 18
    t.text "marketing_bullets__c"
    t.string "patent_ncs__c", limit: 255
    t.text "days_since_next_step_updated"
    t.string "acquisition_name__c", limit: 240
    t.text "comparables__c"
    t.string "notice_waiver__c", limit: 5
    t.string "name_copy_unique__c", limit: 240
    t.string "direct_notice_waiver__c", limit: 5
    t.string "color_code__c", limit: 3
    t.text "pa_documents_reviewed__c"
    t.string "sector_representative__c", limit: 18
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.decimal "no_of_non_party_entity_records", precision: 18
    t.decimal "no_of_non_party_entity_record0", precision: 18
    t.decimal "no_of_non_party_entity_record1", precision: 18
    t.decimal "no_of_non_party_entity_record2", precision: 18
    t.string "most_recent_valuation_tracking", limit: 18
    t.datetime "valuation_date__c"
    t.string "intent_to_litigate__c", limit: 5
    t.datetime "nda_expiration_date__c"
    t.string "fee__c", limit: 5
    t.string "timeline__c", limit: 765
    t.string "hold_reasons__c", limit: 255
    t.string "seller_s_expectation_an_estima", limit: 5
    t.string "most_recent_valuation_trackin0", limit: 18
    t.datetime "valuation_date_guidance__c"
    t.string "new_net_revenue_gross_margin_e", limit: 60
    t.string "insight_id__c", limit: 240
    t.datetime "insight_updated_time__c"
    t.text "amount_for_pipeline_notes__c"
    t.text "seller_s_explicit_expectation"
    t.string "brief_technology_description", limit: 255
    t.string "validity_notes__c", limit: 140
    t.string "most_recent_valuation_trackin1", limit: 18
    t.datetime "valuation_date_bid__c"
  end

  create_table "acquisition_opportunity__hist", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "parentid", limit: 18
    t.string "createdbyid", limit: 18
    t.datetime "createddate"
    t.string "field", limit: 255
    t.string "oldvalue", limit: 765
    t.string "newvalue", limit: 765
    t.index ["id"], name: "uacquisition_opportunity__hist", unique: true
    t.index ["parentid", "field", "createddate"], name: "a_o_hist_parent_field_createdate_idx"
  end

  create_table "acquisition_option_patents", id: false, force: :cascade do |t|
    t.integer "acquisition_option_id", null: false
    t.integer "acquisition_patent_id", null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.serial "id", null: false
  end

  create_table "acquisition_options", id: :serial, force: :cascade do |t|
    t.integer "acquisition_id", null: false
    t.integer "option_type_id", null: false
    t.string "entity_sf_account_id"
    t.integer "option_count", limit: 2
    t.decimal "option_price"
    t.date "effective_date"
    t.date "expiration_date"
    t.string "notes"
    t.boolean "all_patents"
    t.string "name"
    t.date "exercised_date"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.datetime "verified_at"
    t.integer "divestiture_id"
    t.boolean "not_interested", default: false, null: false
  end

  create_table "acquisition_options_bkup_19jan_2016", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "acquisition_id"
    t.integer "option_id"
    t.integer "option_type_id"
    t.string "entity_sf_account_id"
    t.integer "option_count", limit: 2
    t.decimal "option_price"
    t.date "effective_date"
    t.date "expiration_date"
    t.string "notes"
    t.boolean "all_patents"
    t.string "name"
    t.date "exercised_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.datetime "verified_at"
    t.integer "divestiture_id"
  end

  create_table "acquisition_patent_attributes", id: :serial, force: :cascade do |t|
    t.integer "acquisition_patent_id", null: false
    t.string "comments", limit: 2048
    t.integer "case_type_id"
    t.string "subcase"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.index ["acquisition_patent_id"], name: "idx_acquisition_pats_attribs_aqp_id"
  end

  create_table "acquisition_patent_attributes_dcl", id: :serial, force: :cascade do |t|
    t.integer "acquisition_patent_id", null: false
    t.integer "acquisition_patent_attribute_id", null: false
    t.string "comments", limit: 2048
    t.integer "case_type_id"
    t.string "subcase"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.index ["acquisition_patent_id"], name: "acquisition_patents_attr_dcl_idx1"
  end

  create_table "acquisition_patents", id: :serial, force: :cascade do |t|
    t.string "stripped_patnum", limit: 32
    t.string "country_code", limit: 8, null: false
    t.integer "acquisition_id", null: false
    t.integer "portfolio_id"
    t.string "application_number", limit: 50
    t.date "expiration_date"
    t.date "publication_date"
    t.string "case_number", limit: 50
    t.integer "asset_status_type_id"
    t.integer "cpi_tracking_status_id", null: false
    t.datetime "cpi_tracking_date"
    t.boolean "is_asset_matched"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.string "patnum", limit: 255
    t.string "asset_source", limit: 1, default: "U", null: false
    t.integer "asset_source_id", default: -1, null: false
    t.date "annuity_payment_date"
    t.boolean "terminal_disclaimer"
    t.integer "number_of_claims"
    t.text "title"
    t.date "priority_date"
    t.date "filing_date"
    t.date "issue_date"
    t.boolean "is_application"
    t.integer "pat_family_id"
    t.boolean "is_dcl_populated", default: false
    t.string "publication_number", limit: 50
    t.integer "created_by_user_id"
    t.integer "updated_by_user_id"
    t.index ["acquisition_id", "asset_source", "asset_source_id"], name: "acquisition_patents_acquisition_id_asset_source_asset_sourc_idx", unique: true
    t.index ["asset_source_id", "asset_source"], name: "idx_acquisition_patents_asset_source_id"
    t.index ["stripped_patnum", "country_code"], name: "idx1_acq_pats_str_pat_ctry"
  end

  create_table "acquisition_patents_current_assignee_aliases", id: :serial, force: :cascade do |t|
    t.integer "acquisition_patent_id"
    t.integer "alias_id"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "acquisition_patents_dcl", id: :serial, force: :cascade do |t|
    t.integer "acquisition_patent_id"
    t.integer "acquisition_id"
    t.integer "portfolio_id"
    t.string "patnum", limit: 255
    t.string "stripped_patnum", limit: 32
    t.string "country_code", limit: 8, null: false
    t.string "application_number", limit: 50, null: false
    t.date "expiration_date"
    t.date "publication_date"
    t.string "publication_number", limit: 50
    t.string "case_number", limit: 50
    t.integer "asset_status_type_id"
    t.integer "cpi_tracking_status_id", null: false
    t.datetime "cpi_tracking_date"
    t.boolean "is_asset_matched"
    t.string "asset_source", limit: 1, default: "U", null: false
    t.integer "asset_source_id", default: -1, null: false
    t.text "title"
    t.date "issue_date"
    t.date "priority_date"
    t.boolean "is_application"
    t.integer "pat_family_id"
    t.date "filing_date"
    t.date "annuity_payment_date"
    t.boolean "terminal_disclaimer"
    t.integer "number_of_claims"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.integer "created_by_user_id"
    t.integer "updated_by_user_id"
    t.index ["acquisition_id", "asset_source", "asset_source_id"], name: "acquisition_patents_dcl_acquisition_id_asset_source_asset_s_idx", unique: true
    t.index ["acquisition_id", "portfolio_id"], name: "acquisition_patents_dcl_idx2"
    t.index ["stripped_patnum", "country_code"], name: "acquisition_patents_dcl_idx1"
  end

  create_table "acquisition_patents_dcl_current_assignee_aliases", id: :serial, force: :cascade do |t|
    t.integer "acquisition_patent_dcl_id"
    t.integer "alias_id"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "acquisition_patents_dcl_rpx_ownership_rights", id: :serial, force: :cascade do |t|
    t.integer "acquisition_patents_dcl_id", null: false
    t.integer "rpx_ownership_right_id"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "acquisition_patents_dcl_rpx_ownership_rights_del_ds_6192_bkup", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "acquisition_patents_dcl_id"
    t.integer "rpx_ownership_right_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "acquisition_restriction_patents", id: false, force: :cascade do |t|
    t.integer "acquisition_restriction_id", null: false
    t.integer "acquisition_patent_id", null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.serial "id", null: false
  end

  create_table "acquisition_restrictions", id: :serial, force: :cascade do |t|
    t.integer "acquisition_id", null: false
    t.integer "restriction_type_id", null: false
    t.string "notes"
    t.string "entity_sf_account_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "all_patents"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "acquisition_syndications", id: :serial, force: :cascade do |t|
    t.integer "acquisition_id", null: false
    t.string "notes"
    t.decimal "amount", precision: 12, scale: 2
    t.string "entity_sf_account_id"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.index ["acquisition_id", "entity_sf_account_id"], name: "acquisition_syndications_acquisition_id_entity_sf_account_i_idx", unique: true
  end

  create_table "acquisition_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "acquisitions", id: :serial, force: :cascade do |t|
    t.string "acquisition_name", limit: 512, null: false
    t.date "acquisition_date"
    t.integer "acquisition_type_id", null: false
    t.datetime "published_at"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.string "legal_lead_sf_userx_id", limit: 18
    t.integer "counter_party_type_id"
    t.boolean "is_published_to_portal", default: false
    t.boolean "is_prior_encumbrances", default: false
    t.index ["acquisition_name"], name: "acquisitions_acquisition_name_idx"
  end

  create_table "adaptix_assets_dump", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "family"
    t.text "patent_number_raw"
    t.text "publication_number_raw"
    t.text "application_number_raw"
    t.text "country"
    t.text "title"
    t.text "application_status"
    t.text "filed_date_actual"
    t.text "publication_date_actual"
    t.text "issue_date_actual"
    t.text "current_assignee"
    t.text "annuity_fee_status"
    t.date "expiration_date"
    t.text "notes"
    t.text "type"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
    t.string "publication_number", limit: 2048
    t.date "filed_date"
    t.date "publication_date"
    t.date "issue_date"
  end

  create_table "agreement_terms", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "agreement_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

# Could not dump table "alias_contacts" because of following NoMethodError
#   undefined method `to_sym' for nil:NilClass

  create_table "alias_ent_details", id: :serial, force: :cascade do |t|
    t.integer "alias_id"
    t.integer "ent_id"
    t.integer "ultimate_parent_id"
    t.string "alias_name", limit: 512
    t.string "ent_name"
    t.string "ultimate_parent_name"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 255
    t.string "updated_by", limit: 255
    t.boolean "is_npe", default: false
    t.boolean "is_patent_licensing_co", default: false
    t.boolean "is_defensive_entity", default: false
    t.integer "factset_company_id"
    t.boolean "is_non_human"
    t.integer "alias_roles", array: true
    t.text "clean_name"
    t.integer "ent_type_id"
    t.datetime "alias_created_at"
    t.datetime "ent_created_at"
    t.integer "soft_ent_id"
    t.integer "soft_ultimate_parent_id"
    t.text "soft_ultimate_parent_name"
    t.string "sf_account_id", limit: 18
    t.string "sf_account_type", limit: 255
    t.boolean "is_a_bad_alias", default: false
    t.index "alias_name gin_trgm_ops", name: "idx_alias_ent_details_alias_name", using: :gin
    t.index "ent_name gin_trgm_ops", name: "idx_alias_ent_details_ent_name", using: :gin
    t.index "ultimate_parent_name gin_trgm_ops", name: "idx_alias_ent_details_ultimate_parent_name", using: :gin
    t.index ["alias_created_at"], name: "idx_alias_ent_details_alias_created_at"
    t.index ["alias_id", "ent_id"], name: "idx_alias_ent_details_alias_ent"
    t.index ["alias_roles"], name: "idx_alias_ent_details_alias_roles", using: :gin
    t.index ["clean_name"], name: "idx_alias_ent_details_clean_anme"
    t.index ["ent_created_at"], name: "idx_alias_ent_details_ent_created_at"
    t.index ["ent_id"], name: "idx_alias_ent_details_ent_id"
    t.index ["ent_type_id"], name: "idx_alias_ent_details_ent_type_id"
    t.index ["is_npe"], name: "idx_alias_ent_details_true_npe", where: "is_npe"
    t.index ["is_patent_licensing_co"], name: "idx_alias_ent_details_true_is_patent_licensing_co", where: "is_patent_licensing_co"
    t.index ["soft_ent_id"], name: "idx_alias_ent_details_soft_ent_id"
    t.index ["soft_ultimate_parent_id"], name: "idx_alias_ent_detail_soft_ultimate_parent_id"
    t.index ["soft_ultimate_parent_name"], name: "idx_alias_ent_details_soft_ultimate_parent_name"
    t.index ["ultimate_parent_id"], name: "idx_alias_ent_details_ultimate_parent_id"
    t.index ["updated_at"], name: "idx_alias_ent_details_updated_at"
  end

  create_table "alias_ent_details_bkp_soft_ent_updt", id: false, force: :cascade do |t|
    t.integer "alias_id"
    t.integer "ent_id"
    t.integer "ultimate_parent_id"
    t.string "alias_name", limit: 512
    t.string "ent_name"
    t.string "ultimate_parent_name"
    t.integer "id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 255
    t.string "updated_by", limit: 255
    t.boolean "is_npe"
    t.boolean "is_patent_licensing_co"
    t.boolean "is_defensive_entity"
    t.integer "factset_company_id"
    t.boolean "is_non_human"
    t.integer "alias_roles", array: true
    t.text "clean_name"
    t.integer "ent_type_id"
    t.datetime "alias_created_at"
    t.datetime "ent_created_at"
    t.integer "soft_ent_id"
  end

  create_table "alias_reference_table_info", primary_key: ["alias_reference_table_name", "alias_reference_column_name"], force: :cascade do |t|
    t.string "alias_reference_table_name", null: false
    t.string "alias_reference_column_name", null: false
    t.boolean "is_enabled", default: true
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
  end

  create_table "alias_roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 32
    t.text "source_tables", array: true
    t.datetime "created_at", default: -> { "now()" }
    t.string "created_by", limit: 32
    t.text "sql_filter"
    t.index ["name"], name: "idx_alias_roles_name", unique: true
  end

  create_table "aliases", id: :serial, force: :cascade, comment: "Names of people and companies exactly as they appear from our various data sources." do |t|
    t.string "name", limit: 512, null: false, comment: "Alias name exactly as it appears from PACER, USPTO, etc."
    t.string "lower_stripped", limit: 512, null: false, comment: "Name as seen lower cased and stripped of punctuation."
    t.string "core_name", limit: 512, null: false, comment: "Name converted automatically to core form (remove Co, Inc, LLC, etc. and proper cased), for use in name disambiguation."
    t.string "fingerprint", limit: 512, null: false, comment: "Name converted automatically to fingerprint (only alpha/numeric characters, lower cased and sorted), for use in name disambiguation."
    t.integer "ent_id", comment: "Entity id (key to link to ents table)"
    t.boolean "is_verified", default: false, null: false, comment: "Has the alias->ent mapping been approved by a human?"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.string "clean_name", limit: 512, null: false
    t.string "created_by", limit: 255
    t.string "verified_by", limit: 255
    t.boolean "is_automatch_processed", default: false
    t.index "lower((name)::text)", name: "idx_core_aliases_lower_name"
    t.index "name gin_trgm_ops", name: "idx_aliases_name_gin1", using: :gin
    t.index ["clean_name", "is_verified"], name: "aliases__clean_name__is_verified_idx"
    t.index ["clean_name"], name: "aliases_clean_name_idx", using: :gist
    t.index ["core_name"], name: "aliases__core_name_trgm_idx", using: :gist
    t.index ["created_at"], name: "aliases__created_at_idx"
    t.index ["ent_id"], name: "aliases_fkey_ent_id"
    t.index ["fingerprint"], name: "aliases__fingerprint_trgm_idx", using: :gist
    t.index ["name"], name: "idx_core_aliases_name"
    t.index ["updated_at"], name: "aliases__updated_at_idx"
  end

  create_table "all_accounts", id: :string, limit: 64, force: :cascade do |t|
  end

  create_table "all_acquisition_opportunities", id: :string, limit: 64, force: :cascade do |t|
  end

  create_table "analyst_overall_score_final_missed_tmp", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.decimal "overall_score"
  end

  create_table "analyst_overall_score_tmp", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.float "overall_score"
  end

  create_table "analyst_overall_score_tmp_1", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.decimal "overall_score"
    t.index ["pat_id"], name: "analyst_overall_score_tmp_1_pat_id_idx"
  end

  create_table "application__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "ast__c", limit: 5
    t.string "acquisitions_or_divertituters", limit: 5
    t.string "all_other_names_under_which_ap", limit: 765
    t.datetime "anticipated_s_1_filling_date"
    t.string "any_acquisitions__c", limit: 255
    t.string "any_insurance_covering_patent", limit: 255
    t.string "any_product_line__c", limit: 255
    t.text "applicant_anticipation__c"
    t.string "applicant_will_raise_capital_i", limit: 255
    t.string "company_address_city__c", limit: 240
    t.string "company_address_country__c", limit: 240
    t.string "company_address_state__c", limit: 255
    t.string "company_address_street_2__c", limit: 240
    t.string "company_address_zip_code__c", limit: 30
    t.string "company_address__c", limit: 240
    t.string "company_name__c", limit: 18
    t.string "company_website__c", limit: 765
    t.string "customers_accounting_for_10_of", limit: 255
    t.string "dist_channels_partners_marketi", limit: 5
    t.string "e_commerce_capabilities__c", limit: 255
    t.string "entity_type__c", limit: 255
    t.string "expansion_to_new_geographic_lo", limit: 5
    t.string "fiscal_year_ended__c", limit: 255
    t.text "indicate_which_orgs__c"
    t.string "insurer_name__c", limit: 240
    t.string "is_company_publicly_traded__c", limit: 255
    t.string "is_parent_company_publicly_tra", limit: 255
    t.string "member_of_any_defensive_buying", limit: 255
    t.string "new_products_or_services__c", limit: 5
    t.string "notes_acqdis__c", limit: 765
    t.string "notes_exptonewgeo__c", limit: 765
    t.string "notes_newprodservices__c", limit: 765
    t.string "notes_partners__c", limit: 765
    t.string "oin__c", limit: 5
    t.string "parent_company_ticker_symbol", limit: 30
    t.string "parent_company__c", limit: 240
    t.string "past_insurer_name__c", limit: 240
    t.string "patent_re_examinations_or_revi", limit: 765
    t.string "patent_related_insurance_in_th", limit: 255
    t.text "please_describe_any_other_acti"
    t.string "primary_contact__c", limit: 18
    t.string "rpx__c", limit: 5
    t.string "status__c", limit: 255
    t.string "target_amount_of_capital__c", limit: 765
    t.string "ticker_symbol__c", limit: 30
    t.string "unified_patents__c", limit: 5
    t.string "what_year_was_the_applicant_fo", limit: 12
    t.string "accepted_terms__c", limit: 5
    t.string "any_other_indemnification_requ", limit: 255
    t.string "applicant_ever_been_in_a_paten", limit: 255
    t.string "applicant_raised_any_material", limit: 255
    t.string "customer_details_notes__c", limit: 765
    t.string "did_you_develop_them_all_yours", limit: 255
    t.datetime "expiration_date_of_policy__c"
    t.datetime "expiration_dates_of_coverage"
    t.string "have_you_received_any_assertio", limit: 255
    t.string "ipo__c", limit: 5
    t.string "key_financial_notes__c", limit: 765
    t.string "market__c", limit: 60
    t.string "other_defensive_buying_organiz", limit: 765
    t.string "other__c", limit: 5
    t.string "private_capital__c", limit: 5
    t.string "product_details_notes__c", limit: 765
    t.string "short_form__c", limit: 5
    t.text "what_is_the_source_of_capital"
    t.string "opportunity__c", limit: 18
    t.string "ast_verified__c", limit: 5
    t.string "acq_divestitures_past_3_yrs_ve", limit: 255
    t.string "acquisitions_or_divestitures_v", limit: 5
    t.datetime "anticipated_s_1_filling_date_v"
    t.text "applicant_anticipation_verifie"
    t.string "been_in_patent_infringement_ve", limit: 255
    t.string "company_address_city_verified", limit: 240
    t.string "company_address_country_verifi", limit: 240
    t.string "company_address_state_verified", limit: 255
    t.string "company_address_street_2_verif", limit: 240
    t.string "company_address_street_verifie", limit: 240
    t.string "company_address_zip_code_verif", limit: 240
    t.string "company_name_verified__c", limit: 240
    t.string "company_website_verified__c", limit: 765
    t.text "customer_details_notes_verifie"
    t.string "customers_10_of_revenue_verifi", limit: 255
    t.string "developed_all_e_commerce_verif", limit: 255
    t.string "dist_channel_partner_mrktng_ve", limit: 5
    t.string "e_commerce_capabilities_verifi", limit: 255
    t.string "entity_type_verified__c", limit: 255
    t.string "expansion_to_new_locations_ver", limit: 5
    t.datetime "expiration_date_of_policy_veri"
    t.datetime "expiration_dates_of_coverage_v"
    t.string "fiscal_year_ended_verified__c", limit: 255
    t.string "ipo_verified__c", limit: 5
    t.string "indemnification_requests_verif", limit: 255
    t.text "indicate_which_orgs_verified"
    t.string "insurance_covering_patent_lits", limit: 255
    t.string "insurer_name_verified__c", limit: 240
    t.string "is_company_publicly_traded_ver", limit: 255
    t.string "is_parent_co_publicly_traded_v", limit: 255
    t.text "key_financial_notes_verified"
    t.string "market_verified__c", limit: 60
    t.string "member_of_defensive_buy_orgs_v", limit: 255
    t.string "new_products_or_services_verif", limit: 5
    t.string "notes_acqdiv_verified__c", limit: 765
    t.string "notes_expansion_verified__c", limit: 765
    t.string "notes_newprodservices_verified", limit: 765
    t.string "notes_partners_verified__c", limit: 765
    t.string "oin_verified__c", limit: 5
    t.string "operating_names_verified__c", limit: 765
    t.string "other_defensive_buy_org_verifi", limit: 765
    t.text "other_actions_taken_verified"
    t.string "other_verified__c", limit: 5
    t.string "parent_company_ticker_symbol_v", limit: 30
    t.string "parent_company_verified__c", limit: 240
    t.string "past_insurer_name_verified__c", limit: 240
    t.string "past_patent_related_insurance", limit: 255
    t.string "patent_re_exams_reviews_5_yrs", limit: 765
    t.string "primary_contact_verified__c", limit: 240
    t.string "private_capital_verified__c", limit: 5
    t.text "product_details_notes_verified"
    t.string "products_10_revenue_verified", limit: 255
    t.string "rpx_verified__c", limit: 5
    t.string "raised_any_material_funding_ve", limit: 255
    t.string "received_assertion_letters_ver", limit: 255
    t.text "source_of_capital_raising_veri"
    t.string "target_amount_of_capital_verif", limit: 765
    t.string "ticker_symbol_verified__c", limit: 30
    t.string "unified_patents_verified__c", limit: 5
    t.string "will_raise_capital_in_12mo_ver", limit: 255
    t.string "year_applicant_founded_verifie", limit: 12
    t.datetime "last_email_triggered_time__c"
    t.string "cloned_from__c", limit: 18
    t.string "is_cloned_for_renewal__c", limit: 5
    t.string "is_verification_version__c", limit: 5
    t.datetime "modified_time_for_reporting__c"
    t.string "any_cases_associated_with_the", limit: 255
    t.string "any_patent_re_examinations_rev", limit: 255
    t.string "account_owner_mail__c", limit: 240
    t.string "assigned_uw__c", limit: 18
    t.string "last_updated_user_id__c", limit: 54
    t.string "opportunity_owner__c", limit: 18
    t.datetime "lastactivitydate"
    t.string "opportunity_owner_name__c", limit: 765
    t.string "opportunity_owner_email__c", limit: 240
    t.string "broker_company__c", limit: 765
    t.string "broker_email__c", limit: 240
    t.string "broker_first_name__c", limit: 765
    t.string "broker_last_name__c", limit: 765
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.decimal "complete__c", precision: 18, scale: 2
    t.string "flr_master__c", limit: 18
    t.string "ecosystem_version__c", limit: 18
    t.index ["id"], name: "uapplication__c", unique: true
  end

  create_table "assertion__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "application__c", limit: 18
    t.decimal "amount_of_indemnification_paid", precision: 24, scale: 6
    t.datetime "first_contact_date__c"
    t.datetime "last_contact_date__c"
    t.decimal "legal_cost__c", precision: 24, scale: 6
    t.decimal "license_resolution__c", precision: 24, scale: 6
    t.string "matter_name__c", limit: 765
    t.string "parent_plaintiff__c", limit: 240
    t.string "patents__c", limit: 765
    t.datetime "resolved_date__c"
    t.string "seeking_indemnification__c", limit: 255
    t.string "settlement_details__c", limit: 765
    t.string "supplier_seeking_indemnificati", limit: 240
    t.string "technology_asserted__c", limit: 240
    t.string "assertion_status__c", limit: 255
    t.string "comments__c", limit: 765
    t.string "did_you_get_any_indemnificatio", limit: 255
    t.decimal "estimated_to_others__c", precision: 22, scale: 6
    t.decimal "estimated_to_you__c", precision: 22, scale: 6
    t.decimal "amount_of_indemnification_pai0", precision: 24, scale: 6
    t.string "any_indemnification_requests_v", limit: 255
    t.string "assertion_status_verified__c", limit: 255
    t.string "comments_verified__c", limit: 765
    t.decimal "estimated_to_others_verified", precision: 22, scale: 6
    t.decimal "estimated_to_you_verified__c", precision: 22, scale: 6
    t.datetime "first_contact_date_verified__c"
    t.datetime "last_contact_date_verified__c"
    t.decimal "legal_cost_verified__c", precision: 24, scale: 6
    t.decimal "license_resolution_verified__c", precision: 24, scale: 6
    t.datetime "resolved_date_verified__c"
    t.string "seeking_indemnification_verifi", limit: 255
    t.string "settlement_details_verified__c", limit: 765
    t.string "supplier_seeking_indemn_from_v", limit: 240
    t.string "technology_asserted_verified", limit: 240
    t.string "accused_products__c", limit: 765
    t.string "court__c", limit: 150
    t.string "how_resolved_stage_reached__c", limit: 765
    t.string "include_in_frequency__c", limit: 5
    t.string "include_in_severity__c", limit: 5
    t.string "ncs__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "rpx_deal_involvement__c", limit: 255
    t.string "copy_reference__c", limit: 54
    t.string "non_competing_entity__c", limit: 5
    t.boolean "competitor__c"
    t.index ["id"], name: "uassertion__c", unique: true
  end

  create_table "asset_inventory_cpi", id: :serial, force: :cascade do |t|
    t.string "client", limit: 200
    t.string "run_date", limit: 30
    t.string "case_number", limit: 200
    t.string "country", limit: 200
    t.string "wipo", limit: 200
    t.string "subcase", limit: 200
    t.string "client_division", limit: 200
    t.string "case_type", limit: 200
    t.string "status", limit: 200
    t.string "application_number", limit: 200
    t.string "filing_date", limit: 30
    t.string "patent_number", limit: 200
    t.string "issue_date", limit: 30
    t.string "publication_number", limit: 200
    t.string "publication_date", limit: 30
    t.string "expiration_date", limit: 200
    t.text "title"
    t.string "db_comments", limit: 20
    t.string "db_query", limit: 500
    t.integer "core_pats_id"
    t.integer "docdb_pats_id"
    t.string "acquisition_id", limit: 20
    t.string "portfolio_id", limit: 50
    t.string "right_type", limit: 200
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.string "batch_number", limit: 30
    t.string "patnum", limit: 32
    t.index ["patent_number", "wipo"], name: "idx_cpi_only_assets_patnum_wipo"
  end

  create_table "asset_sources", id: :serial, force: :cascade do |t|
    t.string "asset_source_name", limit: 1, null: false
    t.text "asset_source_description", null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "asset_status_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.string "description", limit: 200
    t.boolean "is_default"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "assignees_aliases_map", id: :serial, force: :cascade do |t|
    t.integer "assignment_id", null: false
    t.integer "alias_id", null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "alias_contact_id"
    t.boolean "is_verified", default: false, null: false, comment: "has the alias->assignees mapping been approved by a human?"
    t.string "verified_by", limit: 255
    t.text "notes"
    t.index ["alias_contact_id"], name: "assignees_aliases_map__alias_contact_id_idx"
    t.index ["alias_id"], name: "assignees_aliases_map_fkey_alias_id"
    t.index ["assignment_id", "alias_id"], name: "assignees_aliases_map__assignment_id_alias_id_uniq_idx", unique: true
    t.index ["assignment_id"], name: "assignees_aliases_map_fkey_assignment_id"
  end

  create_table "assignors_aliases_map", id: :serial, force: :cascade do |t|
    t.integer "assignment_id", null: false
    t.integer "alias_id", null: false
    t.date "execution_date", null: false, comment: "when this assignor executed their part of assignment.\ntds: assd.assd_sd"
    t.date "acknowledged_date", comment: "from rawdb.rpx.us_patent_assignments.date_acknowledged\ndate PTO recognized this assignors paperwork\n\"only present when no execution date availble\"\ntds: assd_da"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "alias_contact_id"
    t.boolean "is_verified", default: false, null: false, comment: "has the alias->assignors mapping been approved by a human?"
    t.text "notes"
    t.string "verified_by", limit: 255
    t.index ["alias_contact_id"], name: "idx_assignors_aliases_map_contact_id"
    t.index ["alias_id"], name: "assignors_aliases_map_fkey_alias_id"
    t.index ["assignment_id", "alias_id", "execution_date"], name: "assignors_aliases_map__assignment_id_alias_id_execution_date", unique: true
    t.index ["assignment_id"], name: "assignors_aliases_map_fkey_assignment_id"
  end

  create_table "attachment", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "parentid", limit: 18
    t.string "namex", limit: 765
    t.string "isprivate", limit: 5
    t.string "contenttype", limit: 360
    t.decimal "bodylength"
    t.binary "bodyx"
    t.string "ownerid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.text "description"
    t.index ["id"], name: "uattachment", unique: true
  end

  create_table "batch_generated_option_ents", id: :serial, force: :cascade do |t|
    t.integer "option_id", null: false
    t.integer "bgo_type_id", null: false
    t.decimal "option_price"
    t.datetime "notification_sent_at"
    t.integer "bgo_status_id", null: false
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "account_id", limit: 255, null: false
    t.date "expiration_date"
    t.index ["option_id", "account_id"], name: "batch_generated_option_ents_option_id_account_id_idx", unique: true
  end

  create_table "batch_generated_option_statuses", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64, null: false
    t.string "name", limit: 64, null: false
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "batch_generated_option_types", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64, null: false
    t.string "name", limit: 64, null: false
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "case_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.string "description", limit: 200
    t.boolean "is_default"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.index ["name"], name: "case_types_name_key", unique: true
  end

  create_table "channel_prospect__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 80
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "approved__c", limit: 255
    t.string "broker_account__c", limit: 18
    t.string "broker_contact__c", limit: 18
    t.datetime "broker_renewal_date__c"
    t.datetime "last_risk_profile__c"
    t.string "risk_profile_provided__c", limit: 255
    t.string "status__c", limit: 255
    t.string "target__c", limit: 18
    t.string "triage_priority__c", limit: 255
    t.string "broker_s_client_or_prospect__c", limit: 255
    t.index ["id"], name: "uchannel_prospect__c", unique: true
  end

  create_table "claims__claim__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "claims__activity_status__c", limit: 255
    t.string "claims__client__c", limit: 18
    t.datetime "claims__date_notified__c"
    t.text "claims__employee_name_display"
    t.string "claims__employee_name__c", limit: 765
    t.string "claims__external_id__c", limit: 765
    t.decimal "claims__gross_incurred__c", precision: 22, scale: 6
    t.string "claims__incident_report__c", limit: 18
    t.string "claims__location__c", limit: 300
    t.datetime "claims__loss_date__c"
    t.string "claims__loss_description__c", limit: 765
    t.decimal "claims__loss_estimate__c", precision: 22, scale: 6
    t.decimal "claims__net_incurred__c", precision: 22, scale: 6
    t.decimal "claims__net_paid__c", precision: 22, scale: 6
    t.decimal "claims__net_reserve__c", precision: 22, scale: 6
    t.string "claims__policy_detail__c", limit: 18
    t.decimal "claims__reserve_cost__c", precision: 22, scale: 6
    t.decimal "claims__reserve__c", precision: 22, scale: 6
    t.decimal "claims__retained_within_excess", precision: 22, scale: 6
    t.string "claims__status__c", limit: 255
    t.decimal "claims__paid_total__c", precision: 22, scale: 6
    t.decimal "claims__reserve_total__c", precision: 22, scale: 6
    t.decimal "claim_limit_available__c", precision: 22, scale: 6
    t.datetime "date_approved_as_claim__c"
    t.datetime "date_claim_closed__c"
    t.decimal "other_claims_totalf__c", precision: 22, scale: 6
    t.decimal "other_claims_total__c", precision: 22, scale: 6
    t.string "panel_council__c", limit: 5
    t.decimal "policy_limit_available__c", precision: 22, scale: 6
    t.text "remaining_minimum_sir_t__c"
    t.decimal "remaining_minimum_sir__c", precision: 22, scale: 6
    t.decimal "remaining_lae_reserve__c", precision: 22, scale: 6
    t.text "remaining_per_claim_sir_t__c"
    t.decimal "remaining_per_claim_sir__c", precision: 22, scale: 6
    t.decimal "remaining_reserve__c", precision: 22, scale: 6
    t.decimal "resolution_payment_amount__c", precision: 22, scale: 6
    t.datetime "resolution_payment_date__c"
    t.decimal "sir_remaining__c", precision: 22, scale: 6
    t.decimal "stage_1_available__c", precision: 22, scale: 6
    t.datetime "stage_1_end_date__c"
    t.decimal "stage_1_limit__c", precision: 18, scale: 2
    t.datetime "stage_1_start_date__c"
    t.decimal "stage_2_available__c", precision: 22, scale: 6
    t.datetime "stage_2_end_date__c"
    t.decimal "stage_2_limit__c", precision: 18, scale: 2
    t.datetime "stage_2_start_date__c"
    t.decimal "stage_3_available__c", precision: 22, scale: 6
    t.datetime "stage_3_end_date__c"
    t.decimal "stage_3_limit__c", precision: 18, scale: 2
    t.datetime "stage_3_start_date__c"
    t.decimal "stage_4_available__c", precision: 22, scale: 6
    t.datetime "stage_4_end_date__c"
    t.decimal "stage_4_limit__c", precision: 18, scale: 2
    t.datetime "stage_4_start_date__c"
    t.decimal "total_paid_with_resolution__c", precision: 22, scale: 6
    t.decimal "total_paid__c", precision: 22, scale: 6
    t.decimal "total_policy_amount_approved", precision: 22, scale: 6
    t.decimal "total_policy_paid__c", precision: 22, scale: 6
    t.decimal "stage_1_paid__c", precision: 22, scale: 6
    t.decimal "stage_2_paid__c", precision: 22, scale: 6
    t.decimal "stage_3_paid__c", precision: 22, scale: 6
    t.decimal "stage_4_paid__c", precision: 22, scale: 6
    t.decimal "total_amount_approved__c", precision: 22, scale: 6
    t.decimal "total_lae_payments__c", precision: 22, scale: 6
    t.decimal "total_lae_reserve_val__c", precision: 22, scale: 6
    t.decimal "total_reserve_val__c", precision: 22, scale: 6
    t.string "use_per_claim_sir__c", limit: 5
    t.string "claimant__c", limit: 18
    t.decimal "total_paid_per_claim__c", precision: 22, scale: 6
    t.decimal "total_resolution_payment__c", precision: 22, scale: 6
    t.string "acquisition__c", limit: 18
    t.decimal "license_amount__c", precision: 24, scale: 6
    t.string "panel_counsel__c", limit: 5
    t.string "loss_status__c", limit: 765
    t.decimal "gross_reserve__c", precision: 24, scale: 6
    t.decimal "estimated_remaining_minimum_si", precision: 24, scale: 6
    t.decimal "remaining_per_claim_limit_of_l", precision: 24, scale: 6
    t.decimal "co_pay__c", precision: 24, scale: 6
    t.decimal "co_pay__z", precision: 24, scale: 6
    t.decimal "cumulative_incurred_loss__c", precision: 24, scale: 6
    t.decimal "total_net_reserve__c", precision: 22, scale: 6
    t.decimal "remaining_minimum_sir_2__c", precision: 22, scale: 6
    t.decimal "co_pay_impact__c", precision: 22, scale: 6
    t.decimal "estimated_total_expenditures", precision: 22, scale: 6
    t.decimal "initial_est_total_claim_expend", precision: 22, scale: 6
    t.decimal "pre_claim_remaining_aggregate", precision: 22, scale: 6
    t.decimal "initial_loss_reserve__c", precision: 22, scale: 6
    t.decimal "limit_impact__c", precision: 22, scale: 6
    t.decimal "loss_payments__c", precision: 22, scale: 6
    t.decimal "post_claim_aggregate_limit__c", precision: 22, scale: 6
    t.decimal "pre_claim_remaining_minimum_si", precision: 22, scale: 6
    t.decimal "remaining_loss_reserve__c", precision: 22, scale: 6
    t.decimal "revised_pre_payment_loss_reser", precision: 22, scale: 6
    t.decimal "total_incurred_loss__c", precision: 22, scale: 6
    t.decimal "total_remaining_reserve__c", precision: 22, scale: 6
    t.decimal "lae_recoveries__c", precision: 22, scale: 6
    t.decimal "loss_recoveries__c", precision: 22, scale: 6
    t.decimal "qualified_expenditures__c", precision: 22, scale: 6
    t.decimal "revised_pre_payment_lae_reserv", precision: 22, scale: 6
    t.decimal "revised_total_claim_expenditur", precision: 22, scale: 6
    t.decimal "initial_co_pay_impact__c", precision: 22, scale: 6
    t.decimal "initial_limit_impact__c", precision: 22, scale: 6
    t.datetime "date_of_dismissal__c"
    t.string "closing__c", limit: 5
    t.string "refer_to_underwriters__c", limit: 5
    t.string "private__c", limit: 5
    t.datetime "date_case_filed__c"
    t.string "license_contribution_or_option", limit: 5
    t.decimal "total_policy_amount_approved_o", precision: 22, scale: 6
    t.decimal "total_policy_paid_old__c", precision: 22, scale: 6
    t.decimal "remaining_per_claim_sir_old__c", precision: 22, scale: 6
    t.decimal "remaining_aggregate_limit_of_l", precision: 22, scale: 6
    t.decimal "qualified_litigation_expense", precision: 22, scale: 6
    t.decimal "qualified_resolution_payment", precision: 22, scale: 6
    t.decimal "bip_total_policy_amount_approv", precision: 22, scale: 6
    t.decimal "bip_total_policy_paid__c", precision: 22, scale: 6
    t.string "opco__c", limit: 5
    t.decimal "remaining_bip_aggregate_limit", precision: 22, scale: 6
    t.decimal "remaining_bip_minimum_sir__c", precision: 22, scale: 6
    t.decimal "remaining_bip_per_claim_limit", precision: 22, scale: 6
    t.index ["id"], name: "uclaims__claim__c", unique: true
  end

  create_table "claims__claim_payment__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "claims__claim__c", limit: 18
    t.decimal "claims__amount__c", precision: 22, scale: 6
    t.string "claims__cost_heading__c", limit: 255
    t.datetime "claims__date_paid__c"
    t.string "claims__notes__c", limit: 765
    t.text "claims__policy__c"
    t.text "claims__quarter__c"
    t.text "claims__year__c"
    t.decimal "amount_reimbursed__c", precision: 22, scale: 6
    t.decimal "co_ins_amount__c", precision: 22, scale: 6
    t.decimal "current_asir__c", precision: 22, scale: 6
    t.decimal "current_csir__c", precision: 22, scale: 6
    t.datetime "date_received__c"
    t.string "invoice_number__c", limit: 60
    t.string "is_lae__c", limit: 5
    t.decimal "legal_fees__c", precision: 22, scale: 6
    t.decimal "out_of_pocket_expenses__c", precision: 22, scale: 6
    t.text "policy__c"
    t.decimal "prior_amount_claim__c", precision: 22, scale: 6
    t.decimal "prior_amount_policy__c", precision: 22, scale: 6
    t.string "provider__c", limit: 240
    t.string "role__c", limit: 240
    t.string "stage__c", limit: 3
    t.decimal "total_amount_approved__c", precision: 22, scale: 6
    t.string "co_insurance_workflow_run__c", limit: 5
    t.decimal "max__c", precision: 18, scale: 2
    t.string "panel_counsel__c", limit: 5
    t.decimal "asir_for_pay__c", precision: 22, scale: 6
    t.decimal "amount_reimbursed_f__c", precision: 22, scale: 6
    t.decimal "csir_for_pay__c", precision: 22, scale: 6
    t.decimal "claim_running_total__c", precision: 22, scale: 6
    t.decimal "co_ins_amount_f__c", precision: 22, scale: 6
    t.string "make_payment__c", limit: 5
    t.decimal "policy_running_total__c", precision: 22, scale: 6
    t.string "resolution_payment__c", limit: 5
    t.string "use_per_claim_sir__c", limit: 5
    t.decimal "use_per_claim_set__c", precision: 1
    t.decimal "original_legal_fees__c", precision: 22, scale: 6
    t.decimal "original_oop__c", precision: 22, scale: 6
    t.decimal "original_invoice__c", precision: 22, scale: 6
    t.string "is_recovery__c", limit: 5
    t.string "claim_vendor__c", limit: 18
    t.decimal "bip_initial_limit_impact__c", precision: 22, scale: 6
    t.decimal "bip_pre_pay_remaining_aggregat", precision: 22, scale: 6
    t.decimal "bip_pre_pay_remaining_minimum", precision: 22, scale: 6
    t.decimal "pre_remaining_minimum_sir__c", precision: 22, scale: 6
    t.decimal "pre_remaining_per_claim_sir__c", precision: 22, scale: 6
    t.decimal "remaining_aggregate_limit__c", precision: 22, scale: 6
    t.decimal "remaining_bip_per_claim_limit", precision: 22, scale: 6
    t.decimal "remaining_per_claim_limit__c", precision: 22, scale: 6
    t.index ["id"], name: "uclaims__claim_payment__c", unique: true
  end

  create_table "claims__client__c", id: false, force: :cascade do |t|
    t.serial "etl_id", null: false
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "claims__account__c", limit: 18
    t.string "claims__address__c", limit: 765
    t.string "claims__building__c", limit: 765
    t.string "claims__city__c", limit: 150
    t.string "claims__country__c", limit: 255
    t.string "claims__currency__c", limit: 255
    t.string "claims__industry__c", limit: 255
    t.decimal "claims__level__c", precision: 4
    t.string "claims__parent__c", limit: 18
    t.string "claims__post_code__c", limit: 45
    t.string "claims__state_province__c", limit: 765
    t.string "claims__street__c", limit: 765
    t.string "iz", limit: 18
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.datetime "lastactivitydate"
    t.text "sfdc_account_owner__c"
    t.string "client_status__c", limit: 255
    t.string "type__c", limit: 255
    t.string "sector_1__c", limit: 255
    t.string "sector_2__c", limit: 255
    t.string "sector_3__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "secondary_market_sector__c", limit: 255
    t.text "membership_term__c"
    t.string "initial_policy_year__c", limit: 255
    t.string "current_policy_year__c", limit: 255
    t.datetime "current_policy_start_date__c"
    t.datetime "current_policy_end_date__c"
    t.datetime "initial_orientation__c"
    t.datetime "six_month_check_in__c"
    t.datetime "refresh_orientation__c"
    t.datetime "renewal_initiation__c"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "membershiptype__c", limit: 255
    t.string "insured_type__c", limit: 255
    t.string "cd_contact__c", limit: 18
    t.string "broker__c", limit: 18
    t.string "private__c", limit: 5
    t.string "portfolio__c", limit: 40
    t.string "sector_description__c", limit: 200
    t.string "broker_2__c", limit: 18
    t.text "cr_contact__c"
    t.string "insured__c", limit: 255
    t.index ["id"], name: "uclaims__client__c", unique: true
  end

  create_table "claims__cover_type_setup__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "claims__policy_type__c", limit: 18
    t.text "claims__description__c"
    t.string "recordtypeid", limit: 18
    t.decimal "bip_per_claim_limit__c", precision: 22, scale: 6
    t.decimal "bip_remaining_total_aggregate", precision: 22, scale: 6
    t.decimal "bip_remaining_total_minimum_si", precision: 22, scale: 6
    t.decimal "bip_total_aggregate_limit__c", precision: 22, scale: 6
    t.decimal "bip_total_minimum_sir__c", precision: 22, scale: 6
    t.decimal "bip_total_policy_amount_approv", precision: 22, scale: 6
    t.decimal "bip_total_policy_paid__c", precision: 22, scale: 6
    t.string "named_insured__c", limit: 18
    t.index ["id"], name: "uclaims__cover_type_setup__c", unique: true
  end

  create_table "claims__incident_report__c", id: false, force: :cascade do |t|
    t.serial "etl_id", null: false
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.string "recordtypeid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.text "claims__damage_to_insured_vehi"
    t.datetime "claims__date_reported__c"
    t.text "claims__description_of_inciden"
    t.text "claims__details_of_3rd_party_d"
    t.text "claims__details_of_all_any_inj"
    t.text "claims__details_of_theft__c"
    t.string "claims__email__c", limit: 240
    t.string "claims__first_name__c", limit: 60
    t.datetime "claims__incidentdate__c"
    t.string "claims__incidentlocation__c", limit: 90
    t.string "claims__incident_reported_by", limit: 300
    t.string "claims__insured_driver_name__c", limit: 765
    t.string "claims__insured_vehicle_regist", limit: 30
    t.string "claims__last_name__c", limit: 120
    t.text "claims__liability__c"
    t.string "claims__location_map__c", limit: 765
    t.string "claims__police_case_number__c", limit: 150
    t.string "claims__report_completed_by__c", limit: 300
    t.datetime "claims__report_completion_date"
    t.string "claims__title__c", limit: 255
    t.string "alleged_patent_infringement__c", limit: 765
    t.string "client__c", limit: 18
    t.string "cover_type__c", limit: 18
    t.string "description_of_prior_communica", limit: 765
    t.string "description_of_subsequent_comm", limit: 765
    t.string "identified_non_panel_candidate", limit: 765
    t.string "identified_potential_candidate", limit: 765
    t.string "incident_or_event_notification", limit: 255
    t.string "mobile_number__c", limit: 120
    t.string "office_phone_number__c", limit: 120
    t.string "other_policies__c", limit: 255
    t.string "other_policy_information__c", limit: 765
    t.string "other_policy_notice__c", limit: 255
    t.string "potential_claimants__c", limit: 300
    t.string "prior_communications__c", limit: 255
    t.string "subsequent_communications__c", limit: 255
    t.string "conditions_on_claim__c", limit: 765
    t.string "contact_address__c", limit: 765
    t.string "contact_person_position__c", limit: 150
    t.datetime "date_when_served__c"
    t.string "description_of_circumstances", limit: 765
    t.datetime "due_date_first_pleading__c"
    t.string "identified_potential_panel__c", limit: 255
    t.string "insured__c", limit: 120
    t.string "intend_to_engage__c", limit: 255
    t.string "nature_of_monetary_relief__c", limit: 765
    t.string "other_insurers_accepted_as_cla", limit: 255
    t.string "policy_number__c", limit: 90
    t.string "served_with_complaint__c", limit: 255
    t.string "street_address__c", limit: 180
    t.string "specific_alleged_patent_number", limit: 765
    t.string "license_amount_requested__c", limit: 255
    t.decimal "specific_license_amount_reques", precision: 24, scale: 6
    t.string "iz", limit: 18
    t.string "id", limit: 18
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "potential_claimant_lookup__c", limit: 18
    t.string "status__c", limit: 255
    t.decimal "final_license_amount__c", precision: 16, scale: 6
    t.string "pre_inception__c", limit: 5
    t.string "followed_on_from_prior_inciden", limit: 18
    t.string "indemnitee__c", limit: 300
    t.string "indemnitee_lookup__c", limit: 18
    t.string "ir_status__c", limit: 255
    t.string "rpx_acquisition_record__c", limit: 18
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "alleged_patent_infringement_ot", limit: 255
    t.string "patent_holder_or_entity__c", limit: 100
    t.string "private__c", limit: 5
    t.datetime "most_recent_communication__c"
    t.index ["id"], name: "uclaims__incident_report__c", unique: true
  end

  create_table "claims__policy__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "claims__client__c", limit: 18
    t.string "claims__currency__c", limit: 255
    t.string "claims__is_active__c", limit: 5
    t.string "claims__policy_type_lookup__c", limit: 18
    t.text "claims__policy_type_value__c"
    t.string "claims__policy_type__c", limit: 255
    t.string "claims__policy_year__c", limit: 255
    t.decimal "claims__total_net_premium__c", precision: 22, scale: 6
    t.string "policy_year_new__c"
    t.index ["id"], name: "uclaims__policy__c", unique: true
  end

  create_table "claims__policy_detail__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "claims__policy__c", limit: 18
    t.string "claims__cover_type_lookup__c", limit: 18
    t.string "claims__cover_type__c", limit: 255
    t.decimal "claims__deductible__c", precision: 22, scale: 6
    t.text "claims__description__c"
    t.datetime "claims__expiry_date__c"
    t.datetime "claims__inception_date__c"
    t.string "claims__insurer__c", limit: 18
    t.string "claims__is_active__c", limit: 5
    t.string "claims__lead_insurer__c", limit: 765
    t.decimal "claims__limit__c", precision: 22, scale: 6
    t.decimal "claims__net_premium__c", precision: 22, scale: 6
    t.decimal "claims__sums_insured__c", precision: 22, scale: 6
    t.decimal "aggregate_limit_of_liability", precision: 22, scale: 6
    t.decimal "minimum_sir__c", precision: 22, scale: 6
    t.decimal "co_pay_percentage_panel__c", precision: 18, scale: 2
    t.decimal "co_pay_percentage__c", precision: 18, scale: 2
    t.decimal "per_claim_limit_of_liability", precision: 22, scale: 6
    t.decimal "per_claim_sir__c", precision: 22, scale: 6
    t.decimal "policy_limit_available__c", precision: 22, scale: 6
    t.decimal "remaining_aggregate_limit_of_l", precision: 22, scale: 6
    t.decimal "remaining_minimum_sir__c", precision: 22, scale: 6
    t.decimal "stage_1_default_percentage__c", precision: 18, scale: 2
    t.decimal "stage_2_default_percentage__c", precision: 18, scale: 2
    t.decimal "stage_3_default_percentage__c", precision: 18, scale: 2
    t.decimal "stage_4_default_percentage__c", precision: 18, scale: 2
    t.decimal "total_paid_amount__c", precision: 22, scale: 6
    t.decimal "total_policy_amount_approved", precision: 22, scale: 6
    t.decimal "premium_paid__c", precision: 16, scale: 6
    t.string "endorsed__c", limit: 255
    t.decimal "frequency__c", precision: 9, scale: 3
    t.decimal "severity__c", precision: 16, scale: 6
    t.string "client__c", limit: 18
    t.decimal "actuarial_frequency__c", precision: 9, scale: 3
    t.decimal "actuarial_severity__c", precision: 18, scale: 6
    t.string "insurer__c", limit: 255
    t.string "surplus_state_linies__c", limit: 6
    t.string "surplus_lines_state__c", limit: 6
    t.text "endorsements__c"
    t.decimal "bundle_discount_percent__c", precision: 18, scale: 2
    t.decimal "bundle_discount__c", precision: 22, scale: 6
    t.text "deal_comments__c"
    t.decimal "membership_fee__c", precision: 22, scale: 6
    t.string "opportunity__c", limit: 18
    t.decimal "option_fee__c", precision: 22, scale: 6
    t.decimal "rrg_investment_tax__c", precision: 22, scale: 6
    t.decimal "total_invoice__c", precision: 22, scale: 6
    t.string "umr__c", limit: 30
    t.datetime "contract_inception__c"
    t.datetime "contract_expiry__c"
    t.text "class_of_business__c"
    t.decimal "qualified_litigation_expense", precision: 22, scale: 6
    t.decimal "qualified_resolution_payment", precision: 22, scale: 6
    t.decimal "opco_per_claim_limit_of_liabil", precision: 22, scale: 6
    t.decimal "stamping_fee__c", precision: 15, scale: 6
    t.string "recordtypeid", limit: 18
    t.text "named_insured__c"
    t.decimal "bip_total_aggregate_limit__c", precision: 22, scale: 6
    t.decimal "bip_total_per_claim_limit__c", precision: 22, scale: 6
    t.decimal "bip_total_remaining_aggregate", precision: 22, scale: 6
    t.decimal "bip_total_remaining_sir__c", precision: 22, scale: 6
    t.decimal "opco_per_claim_limit__c", precision: 22, scale: 6
    t.decimal "total_bip_incurred_loss__c", precision: 22, scale: 6
    t.decimal "total_bip_policy_amount_approv", precision: 22, scale: 6
    t.decimal "total_bip_policy_paid__c", precision: 22, scale: 6
    t.boolean "competitor_coverage__c"
    t.text "exclusions__c"
    t.text "special_sir_limits__c"
    t.text "scheduled_customers__c"
    t.index ["id"], name: "uclaims__policy_detail__c", unique: true
  end

  create_table "claims__reserve__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "claims__claim__c", limit: 18
    t.decimal "claims__amount__c", precision: 22, scale: 6
    t.string "claims__cost_heading__c", limit: 255
    t.string "claims__notes__c", limit: 765
    t.datetime "claims__reserve_date__c"
    t.string "is_lae__c", limit: 5
    t.index ["id"], name: "uclaims__reserve__c", unique: true
  end

  create_table "contact", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "masterrecordid", limit: 18
    t.string "accountid", limit: 18
    t.string "lastname", limit: 240
    t.string "firstname", limit: 120
    t.string "salutation", limit: 255
    t.string "namex", limit: 363
    t.string "otherstreet", limit: 765
    t.string "othercity", limit: 120
    t.string "otherstate", limit: 240
    t.string "otherpostalcode", limit: 60
    t.string "othercountry", limit: 240
    t.decimal "otherlatitude", precision: 18, scale: 15
    t.decimal "otherlongitude", precision: 18, scale: 15
    t.string "mailingstreet", limit: 765
    t.string "mailingcity", limit: 120
    t.string "mailingstate", limit: 240
    t.string "mailingpostalcode", limit: 60
    t.string "mailingcountry", limit: 240
    t.decimal "mailinglatitude", precision: 18, scale: 15
    t.decimal "mailinglongitude", precision: 18, scale: 15
    t.string "phone", limit: 120
    t.string "fax", limit: 120
    t.string "mobilephone", limit: 120
    t.string "homephone", limit: 120
    t.string "otherphone", limit: 120
    t.string "assistantphone", limit: 120
    t.string "reportstoid", limit: 18
    t.string "email", limit: 240
    t.string "title", limit: 384
    t.string "department", limit: 240
    t.string "assistantname", limit: 120
    t.string "leadsource", limit: 255
    t.datetime "birthdate"
    t.text "description"
    t.string "currencyisocode", limit: 255
    t.string "ownerid", limit: 18
    t.string "hasoptedoutofemail", limit: 5
    t.string "hasoptedoutoffax", limit: 5
    t.string "donotcall", limit: 5
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.datetime "lastcurequestdate"
    t.datetime "lastcuupdatedate"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "emailbouncedreason", limit: 765
    t.datetime "emailbounceddate"
    t.string "isemailbounced", limit: 5
    t.string "photourl", limit: 765
    t.string "jigsaw", limit: 60
    t.string "jigsawcontactid", limit: 60
    t.string "spouse__c", limit: 180
    t.string "divestiture_mailings__c", limit: 5
    t.string "lead_source__c", limit: 180
    t.string "middle__c", limit: 60
    t.string "assistant_s_email__c", limit: 240
    t.string "primary_contact__c", limit: 5
    t.string "profile__c", limit: 765
    t.string "taipei_conference__c", limit: 5
    t.string "top_ip_a_list__c", limit: 5
    t.string "patents_101__c", limit: 5
    t.string "mkto2__inferred_city__c", limit: 765
    t.string "mkto2__inferred_company__c", limit: 765
    t.string "mkto2__inferred_country__c", limit: 765
    t.string "mkto2__inferred_metropolitan_a", limit: 765
    t.string "mkto2__inferred_phone_area_cod", limit: 765
    t.string "mkto2__inferred_postal_code__c", limit: 765
    t.string "mkto2__inferred_state_region", limit: 765
    t.decimal "mkto2__lead_score__c", precision: 18
    t.string "mkto2__original_referrer__c", limit: 765
    t.string "mkto2__original_search_engine", limit: 765
    t.string "mkto2__original_search_phrase", limit: 765
    t.text "mkto2__original_source_info__c"
    t.string "mkto2__original_source_type__c", limit: 765
    t.string "weekly_newsletter__c", limit: 5
    t.string "daily_litigation_alert__c", limit: 5
    t.string "tsr_campaign_1__c", limit: 5
    t.string "tsr_campaign_2__c", limit: 5
    t.string "npe_cost_study_participant__c", limit: 5
    t.string "client_portal_access__c", limit: 5
    t.string "tsr_campaign_3__c", limit: 5
    t.text "contact_type__c"
    t.string "special_mailing_contact__c", limit: 5
    t.string "contact_role__c", limit: 255
    t.string "interested_in_golf_outing__c", limit: 5
    t.string "special_mailing_contact_2__c", limit: 5
    t.string "oct_25th_11_cocktail_reception", limit: 5
    t.string "oct_26th_11_conference_8_30am", limit: 5
    t.string "oct_26th_cocktail_rec_dinner_5", limit: 5
    t.string "lid__linkedin_company_id__c", limit: 240
    t.string "lid__linkedin_member_token__c", limit: 240
    t.string "are_you_bringing_a_1__c", limit: 5
    t.string "verified__c", limit: 5
    t.string "will_you_be_attending_dinner", limit: 255
    t.text "notes__c"
    t.string "us_conferences__c", limit: 5
    t.string "asia_conference__c", limit: 5
    t.string "special_events__c", limit: 5
    t.string "regional_seminars__c", limit: 5
    t.string "periodic_mailings__c", limit: 5
    t.string "legacycontactid__c", limit: 54
    t.string "receive_invoice__c", limit: 5
    t.string "contact_preferences__c", limit: 765
    t.string "pi__campaign__c", limit: 765
    t.text "pi__comments__c"
    t.datetime "pi__conversion_date__c"
    t.string "pi__conversion_object_name__c", limit: 765
    t.string "pi__conversion_object_type__c", limit: 765
    t.datetime "pi__created_date__c"
    t.datetime "pi__first_activity__c"
    t.string "pi__first_search_term__c", limit: 765
    t.string "pi__first_search_type__c", limit: 765
    t.text "pi__first_touch_url__c"
    t.string "pi__grade__c", limit: 30
    t.datetime "pi__last_activity__c"
    t.text "pi__notes__c"
    t.decimal "pi__score__c", precision: 18
    t.string "pi__url__c", limit: 765
    t.string "pi__utm_campaign__c", limit: 765
    t.string "pi__utm_content__c", limit: 765
    t.string "pi__utm_medium__c", limit: 765
    t.string "pi__utm_source__c", limit: 765
    t.string "pi__utm_term__c", limit: 765
    t.string "top_ip_b_list__c", limit: 5
    t.string "insurance_app_contact__c", limit: 5
    t.string "ppp_status__c", limit: 255
    t.string "ppp_role__c", limit: 255
    t.string "region__c", limit: 255
    t.decimal "standard_rate__c", precision: 11, scale: 6
    t.decimal "discounted_rate__c", precision: 11, scale: 6
    t.string "ppp_responsibilities__c", limit: 765
    t.decimal "legal_years_as_of_2015__c", precision: 2
    t.string "recordtypeid", limit: 18
    t.text "ppp_counsel_type__c"
    t.decimal "applications_currently_pending", precision: 18
    t.decimal "applications_completed__c", precision: 18
    t.decimal "policies_placed__c", precision: 18
    t.decimal "cumulative_bookings__c", precision: 18
    t.decimal "pricing_indications_pending__c", precision: 18
    t.decimal "broker_meetings_pending__c", precision: 18
    t.string "auto_created__c", limit: 5
    t.string "patent_risk_digest__c", limit: 5
    t.text "otheraddress"
    t.text "mailingaddress"
    t.string "enabled__c", limit: 255
    t.index ["id"], name: "ucontact", unique: true
  end

  create_table "contentdocument", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "createdbyid", limit: 18
    t.datetime "createddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "isarchived", limit: 5
    t.string "archivedbyid", limit: 18
    t.datetime "archiveddate"
    t.string "isdeleted", limit: 5
    t.string "ownerid", limit: 18
    t.datetime "systemmodstamp"
    t.string "title", limit: 765
    t.string "publishstatus", limit: 255
    t.string "latestpublishedversionid", limit: 18
    t.string "parentid", limit: 18
    t.datetime "updated_at"
    t.datetime "created_at"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.index ["id"], name: "ucontentdocument", unique: true
  end

  create_table "contentversion", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "contentdocumentid", limit: 18
    t.string "islatest", limit: 5
    t.string "contenturl", limit: 765
    t.string "versionnumber", limit: 60
    t.string "title", limit: 765
    t.text "description"
    t.text "reasonforchange"
    t.text "pathonclient"
    t.decimal "ratingcount"
    t.string "isdeleted", limit: 5
    t.datetime "contentmodifieddate"
    t.string "contentmodifiedbyid", limit: 18
    t.decimal "positiveratingcount"
    t.decimal "negativeratingcount"
    t.decimal "featuredcontentboost"
    t.datetime "featuredcontentdate"
    t.string "currencyisocode", limit: 255
    t.string "ownerid", limit: 18
    t.string "createdbyid", limit: 18
    t.datetime "createddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.datetime "systemmodstamp"
    t.text "tagcsv"
    t.string "filetype", limit: 60
    t.string "publishstatus", limit: 255
    t.binary "versiondata"
    t.decimal "contentsize"
    t.string "firstpublishlocationid", limit: 18
    t.string "origin", limit: 255
    t.string "networkid", limit: 18
    t.string "checksumx", limit: 150
    t.string "account__c", limit: 18
    t.string "acquisition__c", limit: 18
    t.string "opportunity__c", limit: 18
    t.string "portal_visible_review__c", limit: 255
    t.string "portal_visible__c", limit: 255
    t.string "portal_visible_final__c", limit: 255
    t.string "nda__c", limit: 255
    t.string "review_status__c", limit: 255
    t.string "type__c", limit: 255
    t.string "patent_analysis_request__c", limit: 18
    t.string "contentlocation", limit: 255
    t.text "externaldocumentinfo1"
    t.text "externaldocumentinfo2"
    t.string "externaldatasourceid", limit: 18
    t.text "assigned_analyst__c"
    t.index ["id"], name: "ucontentversion", unique: true
  end

  create_table "contentversion_bkp", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "contentdocumentid", limit: 18
    t.string "islatest", limit: 5
    t.string "contenturl", limit: 765
    t.string "versionnumber", limit: 60
    t.string "title", limit: 765
    t.text "description"
    t.text "reasonforchange"
    t.text "pathonclient"
    t.decimal "ratingcount"
    t.string "isdeleted", limit: 5
    t.datetime "contentmodifieddate"
    t.string "contentmodifiedbyid", limit: 18
    t.decimal "positiveratingcount"
    t.decimal "negativeratingcount"
    t.decimal "featuredcontentboost"
    t.datetime "featuredcontentdate"
    t.string "currencyisocode", limit: 255
    t.string "ownerid", limit: 18
    t.string "createdbyid", limit: 18
    t.datetime "createddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.datetime "systemmodstamp"
    t.text "tagcsv"
    t.string "filetype", limit: 60
    t.string "publishstatus", limit: 255
    t.binary "versiondata"
    t.decimal "contentsize"
    t.string "firstpublishlocationid", limit: 18
    t.string "origin", limit: 255
    t.string "networkid", limit: 18
    t.string "checksumx", limit: 150
    t.string "account__c", limit: 18
    t.string "acquisition__c", limit: 18
    t.string "opportunity__c", limit: 18
    t.string "portal_visible_review__c", limit: 255
    t.string "portal_visible__c", limit: 255
    t.string "portal_visible_final__c", limit: 255
    t.string "nda__c", limit: 255
    t.string "review_status__c", limit: 255
    t.string "type__c", limit: 255
    t.string "patent_analysis_request__c", limit: 18
    t.string "contentlocation", limit: 255
    t.text "externaldocumentinfo1"
    t.text "externaldocumentinfo2"
    t.string "externaldatasourceid", limit: 18
    t.text "assigned_analyst__c"
    t.index ["id"], name: "contentversion_bkp_id_key", unique: true
  end

  create_table "contracts__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 80
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.datetime "effective_date__c"
    t.datetime "end_date__c"
    t.decimal "term__c", precision: 4
    t.decimal "vesting_mo_s__c", precision: 4
    t.string "company__c", limit: 18
    t.string "legal_name__c", limit: 40
    t.string "notes__c", limit: 255
    t.decimal "year_fee_000s__c", precision: 16, scale: 6
    t.decimal "membership_year__c", precision: 6
    t.decimal "total_payments_received__c", precision: 22, scale: 6
    t.index ["id"], name: "ucontracts__c", unique: true
  end

  create_table "counter_party_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 512, null: false
    t.boolean "is_default", default: false
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "court_abbreviations", id: :serial, force: :cascade do |t|
    t.string "court_name", limit: 255
    t.string "court_abbrev", limit: 100
    t.string "court_abbrev_clean", limit: 100
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
  end

  create_table "court_details", id: :serial, force: :cascade, comment: "District court office details (docketx: divisionaloffice)" do |t|
    t.integer "ent_id", null: false, comment: "Entity id for the district court (key to link to ents)"
    t.string "pacer_label", limit: 255, comment: "Name used by PACER to specify the office (docketx: divisionaloffice.pacerlabel)"
    t.string "district_court_name", limit: 255, null: false, comment: "Full district court name (docketx: divisionaloffice.districtcourtname)"
    t.string "district_court_acronym", limit: 5, null: false, comment: "4 or 5 character abbreviation for the district court, upper case. (docketx: divisionaloffice.districtcourtacronym)"
    t.string "office_name", limit: 255, comment: "Name of the individual office of the district court. (docketx: divisionaloffice.officename)"
    t.integer "office_number", comment: "Office number for district court office, -1 means no office specified (docketx: divisionaloffice.officenumber)"
    t.boolean "is_headoffice", default: false, null: false, comment: "Is the head office for parent district court? (docketx: divisionaloffice.headofficeflag)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.string "court_abbrev", limit: 100
    t.string "court_abbrev_clean", limit: 100
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.float "latitude"
    t.float "longitude"
    t.index ["ent_id"], name: "court_details_fkey_ent_id"
  end

  create_table "cpc_descriptions", id: :serial, force: :cascade do |t|
    t.string "code", limit: 20, null: false
    t.string "code_type", limit: 50, null: false
    t.string "code_desc", limit: 1000
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.index ["code"], name: "cpc_descriptions_code_key", unique: true
  end

  create_table "cpi_data", id: false, force: :cascade do |t|
    t.string "patent_number"
    t.string "country_code"
    t.string "application_number"
    t.string "publication_number"
  end

  create_table "cpi_dump_10_14", id: false, force: :cascade do |t|
    t.text "acquisition_name"
    t.text "acquisition_date"
    t.text "disclosurestatus"
    t.text "applicationstatus"
    t.text "country"
    t.text "invtitle"
    t.text "patnumber"
    t.text "appnumber"
    t.text "fildate"
    t.text "issdate"
  end

  create_table "cpi_file_snapshot", id: :serial, force: :cascade do |t|
    t.integer "run_id"
    t.string "case_number", limit: 50
    t.string "subcase", limit: 50
    t.string "record_status", limit: 1
    t.date "publication_date"
    t.date "filing_date"
    t.date "issue_date"
    t.date "expiration_date"
    t.text "assignee"
    t.string "patent_number", limit: 32
    t.string "country_code", limit: 8
    t.string "application_number", limit: 50
    t.string "case_type", limit: 50
    t.string "asset_status", limit: 20
    t.text "title"
    t.string "publication_number", limit: 50
    t.date "pct_filed_date"
    t.string "pct_number", limit: 50
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "cpi_only_assets", id: false, force: :cascade do |t|
    t.serial "id"
    t.string "client", limit: 200
    t.string "run_date", limit: 30
    t.string "case_number", limit: 200
    t.string "country", limit: 200
    t.string "wipo", limit: 200
    t.string "subcase", limit: 200
    t.string "client_division", limit: 200
    t.string "case_type", limit: 200
    t.string "status", limit: 200
    t.string "application_number", limit: 200
    t.date "filing_date"
    t.string "patent_number", limit: 200
    t.date "issue_date"
    t.string "publication_number", limit: 200
    t.date "publication_date"
    t.date "expiration_date"
    t.text "title"
    t.string "db_comments", limit: 20
    t.string "db_query", limit: 500
    t.integer "core_pats_id"
    t.integer "docdb_pats_id"
    t.string "acquisition_id", limit: 20
    t.string "portfolio_id", limit: 50
    t.string "right_type", limit: 200
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.string "batch_number", limit: 30
    t.string "patnum", limit: 32
    t.index ["patent_number", "country"], name: "cpi_only_assets_patnum_country_idx"
  end

  create_table "cpi_tracking_status", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "defendant_history__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "application__c", limit: 18
    t.decimal "amount_indemnified_for__c", precision: 18
    t.string "applicant_law_firm__c", limit: 765
    t.string "assertion_letter_recieved_prio", limit: 255
    t.decimal "campaign_id__c", precision: 18
    t.string "campaign_name__c", limit: 765
    t.string "case_name__c", limit: 765
    t.datetime "date_of_assertion_letter__c"
    t.text "defendant_names__c"
    t.string "file_date__c", limit: 765
    t.string "indemnification_recieved__c", limit: 255
    t.decimal "litigation_expenses__c", precision: 24, scale: 6
    t.text "notes__c"
    t.text "parent_plaintiff__c"
    t.string "resolve_date__c", limit: 765
    t.decimal "settlement_offer__c", precision: 24, scale: 6
    t.decimal "settlement__c", precision: 24, scale: 6
    t.string "status__c", limit: 255
    t.string "account__c", limit: 18
    t.string "company__c", limit: 765
    t.string "damage_award__c", limit: 765
    t.string "did_you_receive_an_assertion_l", limit: 255
    t.string "did_you_request_indemnificatio", limit: 255
    t.string "exists__c", limit: 5
    t.decimal "legal_cost_prior_to_litigation", precision: 24, scale: 6
    t.datetime "received_date__c"
    t.string "acq_div_company__c", limit: 5
    t.decimal "amount_indemnified_for_verifie", precision: 18
    t.string "applicant_law_firm_verified__c", limit: 765
    t.string "received_prior_to_suit_verifie", limit: 255
    t.string "company_verified__c", limit: 765
    t.string "damage_award_verified__c", limit: 765
    t.datetime "date_of_assertion_letter_verif"
    t.string "assertion_letter_verified__c", limit: 255
    t.string "request_indemnification_verifi", limit: 255
    t.string "file_date_verified__c", limit: 765
    t.string "indemnification_received_verif", limit: 255
    t.decimal "legal_cost_prior_to_litigatio0", precision: 24, scale: 6
    t.decimal "litigation_expenses_verified", precision: 24, scale: 6
    t.text "notes_verified__c"
    t.text "parent_plaintiff_verified__c"
    t.datetime "received_date_verified__c"
    t.string "resolve_date_verified__c", limit: 765
    t.decimal "settlement_verified__c", precision: 24, scale: 6
    t.decimal "settlement_offer_verified__c", precision: 24, scale: 6
    t.string "status_verified__c", limit: 255
    t.string "accused_products__c", limit: 765
    t.string "court__c", limit: 150
    t.string "how_resolved_stage_reached__c", limit: 765
    t.string "include_in_frequency__c", limit: 5
    t.string "include_in_severity__c", limit: 5
    t.string "ncs__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "rpx_deal_involvement__c", limit: 255
    t.string "dca_adjustment__c", limit: 255
    t.string "copy_reference__c", limit: 54
    t.string "product_case__c", limit: 5
    t.boolean "competitor__c"
    t.index ["id"], name: "udefendant_history__c", unique: true
  end

  create_table "deleted_entities_with_rpx_account", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "ent_type_id"
    t.string "name"
    t.string "core_name", limit: 255
    t.string "fingerprint", limit: 255
    t.string "lower_stripped", limit: 255
    t.date "deactivation_date"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "created_by", limit: 255
    t.string "updated_by", limit: 255
    t.string "rpx_account_id", limit: 30
    t.integer "ultimate_parent_id"
    t.integer "rollup_parent_id"
  end

  create_table "deleted_pats_wo_title", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.integer "pat_family_id"
    t.string "stripped_patnum", limit: 32
    t.string "country_code", limit: 4
    t.string "salesforce_id", limit: 64
    t.datetime "created_at"
  end

  create_table "divestiture_patents", id: :serial, force: :cascade do |t|
    t.integer "acquisition_patents_dcl_id", null: false
    t.integer "divestiture_id", null: false
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["divestiture_id", "acquisition_patents_dcl_id"], name: "divestiture_id_acq_patent_id_uniq", unique: true
  end

  create_table "divestitures", id: :serial, force: :cascade do |t|
    t.string "name", limit: 512, null: false
    t.date "divestiture_date"
    t.datetime "published_at"
    t.string "seller_sf_account_id", limit: 64
    t.integer "counter_party_type_id"
    t.string "legal_lead_sf_userx_id", limit: 64
    t.decimal "price"
    t.boolean "is_license_back"
    t.boolean "is_defensive_option"
    t.text "notes"
    t.date "date_offered"
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index "lower((name)::text)", name: "divestitures_lower_idx"
  end

  create_table "dma_lit_annotations", id: :serial, force: :cascade do |t|
    t.integer "lit_id", null: false
    t.string "rpx_lit_id", limit: 16
    t.integer "lit_type_id"
    t.boolean "is_npe_suit", default: false, null: false
    t.boolean "is_dj", null: false
    t.integer "market_sector_type_id"
    t.integer "lit_classification_type_id"
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.boolean "is_abandon", default: false, null: false
    t.text "ad_hoc_1"
    t.text "ad_hoc_2"
    t.text "ad_hoc_3"
    t.text "ad_hoc_4"
    t.text "ad_hoc_5"
    t.integer "lit_curated_cause_type_id"
    t.boolean "is_ncl_suit", default: false, null: false
    t.boolean "is_dcl_corrected"
    t.boolean "lit_annotation_override", default: false
    t.index ["lit_id"], name: "dma_lit_annotations_lit_id_idx", unique: true
    t.index ["lit_type_id"], name: "dma_lit_annotations_lit_type_id_idx"
    t.index ["market_sector_type_id"], name: "dma_lit_annotations_market_sector_type_id_idx"
  end

  create_table "dma_lits_pats_map", id: :serial, force: :cascade do |t|
    t.integer "lit_id", null: false
    t.string "patnum", limit: 15, null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "salesforce_id", limit: 18
    t.boolean "lpm_override", default: false, null: false
    t.index ["lit_id", "patnum"], name: "dma_lits_pats_map_lit_id_patnum_idx", unique: true
    t.index ["lit_id"], name: "dma_lits_pats_map_lit_id_idx"
    t.index ["patnum"], name: "dma_lits_pats_map_patnum_idx"
  end

  create_table "docdb_abstracts", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.text "text", null: false
    t.string "lang", limit: 255
    t.datetime "updated_at", precision: 6
    t.datetime "created_at", precision: 6
    t.string "source", limit: 255
    t.string "country", limit: 255
    t.string "doc_number", limit: 255
    t.string "kind", limit: 255
    t.string "date_published", limit: 255
    t.string "status", limit: 255
    t.string "data_format", limit: 255
    t.integer "batch_id"
    t.integer "run_id"
    t.index ["pat_id"], name: "docdb_abstracts_fkey_pat_id"
  end

  create_table "docdb_applicants", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.string "name", limit: 2048
    t.string "country", limit: 255
    t.string "sequence", limit: 255
    t.string "data_format", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "app_type", limit: 255
    t.string "designation", limit: 255
    t.string "status", limit: 255
    t.string "address", limit: 255
    t.string "nationality", limit: 255
    t.string "us_rights", limit: 255
    t.string "designated_states", limit: 250
    t.string "designated_states_as_inventor", limit: 255
    t.integer "batch_id"
    t.integer "run_id"
    t.index ["pat_id"], name: "docdb_applicants_fkey_pat_id"
  end

  create_table "docdb_batch", id: :serial, force: :cascade do |t|
    t.text "info"
    t.string "range", limit: 255
    t.string "procedure", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "run_id"
  end

  create_table "docdb_citations", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.string "cit_id", limit: 255
    t.string "srep_phase", limit: 255
    t.string "srep_office", limit: 255
    t.string "sequence", limit: 255
    t.string "sub_id", limit: 255
    t.string "num", limit: 255
    t.string "dnum", limit: 255
    t.string "dnum_type", limit: 255
    t.string "file", limit: 255
    t.string "url", limit: 255
    t.string "lang", limit: 255
    t.string "npl_type", limit: 255
    t.string "medium", limit: 255
    t.string "country", limit: 255
    t.string "doc_number", limit: 255
    t.string "kind", limit: 255
    t.string "name", limit: 255
    t.text "text"
    t.string "article", limit: 255
    t.string "book", limit: 255
    t.string "online", limit: 255
    t.string "othercit", limit: 255
    t.string "rel_passage", limit: 255
    t.string "document_id", limit: 255
    t.string "refno", limit: 255
    t.string "category", limit: 255
    t.string "rel_claims", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "batch_id"
    t.integer "run_id"
    t.date "date"
    t.index ["pat_id"], name: "docdb_citations_fkey_pat_id"
  end

  create_table "docdb_classifications", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.string "sequence", limit: 255
    t.string "office", limit: 255
    t.string "scheme", limit: 255
    t.string "classification", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "batch_id"
    t.integer "run_id"
    t.index ["pat_id"], name: "docdb_classifications_fkey_pat_id"
  end

  create_table "docdb_inventors", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.string "inventor_name", limit: 2048, null: false
    t.string "sequence", limit: 255
    t.string "data_format", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "designation", limit: 255
    t.string "status", limit: 255
    t.string "address", limit: 255
    t.string "residence", limit: 255
    t.string "designated_states", limit: 255
    t.string "deceased_inventor", limit: 255
    t.integer "batch_id"
    t.integer "run_id"
    t.index ["pat_id"], name: "docdb_inventors_fkey_pat_id"
  end

  create_table "docdb_ipcs", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.string "sequence", limit: 255
    t.string "ipc_ipcr_text", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "type", limit: 255
    t.string "edition", limit: 255
    t.integer "batch_id"
    t.integer "run_id"
    t.index ["pat_id"], name: "idx_docdb_ipcs_pat_id"
  end

  create_table "docdb_logs", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "batch_id"
    t.string "procedure", limit: 255
    t.text "action"
    t.string "table_name", limit: 255
    t.integer "total_processed"
    t.string "status", limit: 25
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "docdb_national_classifications", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.string "classification_national", limit: 2550, null: false
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "batch_id"
    t.integer "run_id"
    t.index ["pat_id"], name: "docdb_national_classifications_fkey_pat_id"
  end

  create_table "docdb_pat_family_tree", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.string "doc_number", limit: 64
    t.date "doc_date"
    t.string "country", limit: 32
    t.string "patnum", limit: 32
    t.string "app_num_intl", limit: 64
    t.string "stripped_patnum", limit: 32
    t.date "app_date"
    t.string "country_code", limit: 16
    t.string "pat_type", limit: 32
  end

  create_table "docdb_pats", id: :serial, force: :cascade do |t|
    t.string "patnum", limit: 255
    t.string "is_representative", limit: 10
    t.string "originating_office", limit: 25
    t.string "status", limit: 25
    t.string "filedate"
    t.text "title"
    t.string "title_lang", limit: 255
    t.integer "family_id"
    t.string "stripped_patnum", limit: 255
    t.string "extended_kind_code", limit: 255
    t.string "app_num_intl", limit: 25
    t.string "app_num_country", limit: 25
    t.string "lang_of_publication", limit: 25
    t.string "lang_of_filing", limit: 25
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "doc_kind_code", limit: 10
    t.string "publication_number", limit: 255
    t.string "app_is_representative", limit: 255
    t.string "app_kind_code", limit: 255
    t.string "date_of_coming_into_force", limit: 255
    t.string "previously_filed_app", limit: 255
    t.string "country_code", limit: 255
    t.string "public_availability_category", limit: 255
    t.integer "batch_id"
    t.integer "run_id"
    t.string "publication_date_history", limit: 255, default: ""
    t.date "issue_date"
    t.date "app_date"
    t.date "date_of_last_exchange"
    t.date "date_of_previous_exchange"
    t.date "publication_date"
    t.date "date_added_docdb"
    t.date "preceding_publication_date"
    t.date "public_availability_date"
    t.string "doc_number", limit: 255
    t.boolean "pat_family_processed"
    t.index "lower((patnum)::text) varchar_pattern_ops", name: "docdb_pats_lower_idx"
    t.index "patnum gin_trgm_ops", name: "docdb_pats_patnum_idx1", using: :gin
    t.index ["app_num_country"], name: "docdb_pats_app_num_country_idx1"
    t.index ["app_num_intl", "app_num_country"], name: "docdb_pats_app_num_country_idx"
    t.index ["created_at"], name: "docdb_pats__created_at_idx"
    t.index ["family_id"], name: "idx_docdb_pats_family_id"
    t.index ["pat_family_processed"], name: "docdb_pats_pat_family_processed_idx"
    t.index ["patnum"], name: "docdb_pats_patnum_idx"
    t.index ["stripped_patnum", "country_code"], name: "docdb_pats_stripped_patnum_country_idx"
    t.index ["updated_at"], name: "docdb_pats__updated_at_idx"
  end

  create_table "docdb_pats_old", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "patnum", limit: 255
    t.string "is_representative", limit: 10
    t.string "originating_office", limit: 25
    t.string "status", limit: 25
    t.string "filedate"
    t.text "title"
    t.string "title_lang", limit: 255
    t.integer "family_id"
    t.string "stripped_patnum", limit: 255
    t.string "extended_kind_code", limit: 255
    t.string "app_num_intl", limit: 25
    t.string "app_num_country", limit: 25
    t.string "lang_of_publication", limit: 25
    t.string "lang_of_filing", limit: 25
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "doc_kind_code", limit: 10
    t.string "publication_number", limit: 255
    t.string "app_is_representative", limit: 255
    t.string "app_kind_code", limit: 255
    t.string "date_of_coming_into_force", limit: 255
    t.string "previously_filed_app", limit: 255
    t.string "country_code", limit: 255
    t.string "public_availability_category", limit: 255
    t.integer "batch_id"
    t.integer "run_id"
    t.string "publication_date_history", limit: 255
    t.date "issue_date"
    t.date "app_date"
    t.date "date_of_last_exchange"
    t.date "date_of_previous_exchange"
    t.date "publication_date"
    t.date "date_added_docdb"
    t.date "preceding_publication_date"
    t.date "public_availability_date"
    t.string "doc_number", limit: 255
    t.boolean "pat_family_processed"
  end

  create_table "docdb_pats_revision_history", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.string "patnum", limit: 255
    t.string "zip_file_name", limit: 255
    t.string "xml_file_name", limit: 255
    t.string "status", limit: 50
    t.integer "week"
    t.integer "year"
    t.index ["pat_id"], name: "idx_docdb_pats_revision_history_pat_id"
  end

  create_table "docdb_priority_claims", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.bigint "pat_id", null: false
    t.string "sequence", limit: 255
    t.string "doc_number", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "claim_id", limit: 255
    t.string "data_format", limit: 255
    t.string "status", limit: 255
    t.string "lang", limit: 255
    t.string "country", limit: 255
    t.string "kind", limit: 255
    t.string "name", limit: 255
    t.string "office_of_filing", limit: 255
    t.string "priority_doc_requested", limit: 255
    t.string "priority_doc_attached", limit: 255
    t.string "priority_linkage_type", limit: 255
    t.string "priority_active_indicator", limit: 255
    t.integer "batch_id"
    t.integer "run_id"
    t.date "doc_date"
    t.boolean "is_rpx_disabled"
    t.index ["doc_number"], name: "docdb.docdb_priority_claims_doc_number_idx"
    t.index ["pat_id"], name: "docdb_priority_claims_fkey_pat_id"
  end

  create_table "docdb_titles", force: :cascade do |t|
    t.bigint "pat_id", null: false
    t.text "title"
    t.string "lang", limit: 255
    t.string "data_format", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "batch_id"
    t.integer "run_id"
    t.index ["pat_id"], name: "docdb_titles_fkey_pat_id"
  end

  create_table "docket_entries", id: :serial, comment: "Docket entry ID (key connects to docket_entry_documents_map)", force: :cascade, comment: "Row by row docket entries for each litigation." do |t|
    t.integer "lit_id", null: false, comment: "Litigation ID (key connects to lits)"
    t.string "docketx_id", limit: 32, comment: "ID to link back to DOcketX data (docketx: docketentry.id)"
    t.date "date_entered", comment: "Date of docket entry (docketx: docketentry.dateentered)"
    t.date "date_filed", null: false, comment: "Filing date of docket entry (docketx: docketentry.datefiled)"
    t.text "docket_text", comment: "Text of docket entry"
    t.integer "entry_number", default: 0, comment: "PACER docket entry number (docketx: docketentry.entrynumber)"
    t.integer "row_number", null: false, comment: "PriorSmart will provide the exact docket_entry order (not in docketx data)"
    t.text "original_docket_text"
    t.datetime "updated_at", precision: 6, null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", precision: 6, null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_mixed_action", default: false
    t.text "event"
    t.string "category", limit: 255
    t.index "btrim(\"substring\"(lower(docket_text), 1, 80))", name: "docket_entries_substring_docket_text_80_idx"
    t.index "docket_text gist_trgm_ops", name: "docket_entries_docket_text_idx", using: :gist
    t.index ["created_at"], name: "docket_entries_created_at_idx"
    t.index ["date_filed"], name: "idx_docket_entries_date_filed"
    t.index ["lit_id"], name: "docket_entries_fkey_lit_id"
    t.index ["row_number"], name: "docket_entries_row_number_idx"
  end

  create_table "docket_entries_deleted", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "lit_id"
    t.string "docketx_id", limit: 32
    t.date "date_entered"
    t.date "date_filed"
    t.text "docket_text"
    t.integer "entry_number"
    t.integer "row_number"
    t.text "original_docket_text"
    t.datetime "updated_at", precision: 6
    t.datetime "created_at", precision: 6
    t.boolean "is_mixed_action"
    t.text "event"
    t.string "category", limit: 255
  end

  create_table "docket_entry_documents_map", id: :serial, comment: "Artificial key", force: :cascade, comment: "Framework for storing docket documents (connects docket_entries to lit_documents)" do |t|
    t.string "docketx_id", limit: 32, comment: "ID to connect back to the DocketX data (docketx: docketentrydocument.id)"
    t.integer "lit_document_id", comment: "PACER document ID (key connects to lit_documents)"
    t.integer "docket_entry_id", null: false, comment: "Docket entry ID (key connects to docket_entries)"
    t.boolean "is_main", null: false, comment: "Is document a main document?"
    t.datetime "updated_at", precision: 6, null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", precision: 6, null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.index ["docket_entry_id"], name: "docket_entry_documents_map_fkey_docket_entry_id"
    t.index ["is_main"], name: "docket_entry_documents_map_is_main_idx"
    t.index ["lit_document_id", "docket_entry_id", "is_main"], name: "docket_entry_documents_map__ids_is_main_unique", unique: true
    t.index ["lit_document_id"], name: "docket_entry_documents_map_fkey_lit_document_id"
  end

  create_table "docket_entry_documents_map_deleted", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "docketx_id", limit: 32
    t.integer "lit_document_id"
    t.integer "docket_entry_id"
    t.boolean "is_main"
    t.datetime "updated_at", precision: 6
    t.datetime "created_at", precision: 6
  end

  create_table "documents", force: :cascade do |t|
    t.text "ocr_text"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
    t.string "exception"
  end

  create_table "dov_opportunity", id: false, force: :cascade do |t|
    t.integer "etl_id"
    t.string "delete_flag", limit: 1
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "accountid", limit: 18
    t.string "recordtypeid", limit: 18
    t.string "isprivate", limit: 5
    t.string "namex", limit: 360
    t.text "description"
    t.string "stagename", limit: 255
    t.decimal "amount", precision: 22, scale: 6
    t.decimal "probability", precision: 3
    t.decimal "expectedrevenue", precision: 22, scale: 6
    t.decimal "totalopportunityquantity", precision: 18, scale: 2
    t.datetime "closedate"
    t.string "typex", limit: 255
    t.string "nextstep", limit: 765
    t.string "leadsource", limit: 255
    t.string "isclosed", limit: 5
    t.string "iswon", limit: 5
    t.string "forecastcategory", limit: 255
    t.string "forecastcategoryname", limit: 255
    t.string "currencyisocode", limit: 255
    t.string "campaignid", limit: 18
    t.string "hasopportunitylineitem", limit: 5
    t.string "pricebook2id", limit: 18
    t.string "ownerid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.decimal "fiscalquarter"
    t.decimal "fiscalyear"
    t.string "fiscal", limit: 6
    t.string "opportunity_type__c", limit: 255
    t.string "litigation__c", limit: 18
    t.decimal "discount__c", precision: 5, scale: 2
    t.text "private_deal_notes__c"
    t.decimal "historical_rate__c", precision: 24, scale: 6
    t.string "priority__c", limit: 255
    t.text "analysis_notes__c"
    t.text "deal_notes__c"
    t.datetime "bids_due__c"
    t.string "assets__c", limit: 18
    t.string "lead_source_2__c", limit: 180
    t.text "triage_comments__c"
    t.string "source_del__c", limit: 18
    t.string "seller_claims_charts__c", limit: 5
    t.text "current_status__c"
    t.text "portfolio_summary__c"
    t.datetime "start_date__c"
    t.string "seller_loop_closed__c", limit: 5
    t.text "analysis_recommendation__c"
    t.string "seller_s_expectation__c", limit: 300
    t.string "nda__c", limit: 5
    t.string "outside_analysis__c", limit: 150
    t.text "deal_summary__c"
    t.decimal "rpx_rate__c", precision: 21, scale: 6
    t.string "sales_materials_sent__c", limit: 765
    t.datetime "due_date__c"
    t.text "technology_area__c"
    t.string "rpx_project_code__c", limit: 90
    t.string "analysis_assigned_to__c", limit: 18
    t.decimal "no_of_us_patents__c", precision: 18
    t.decimal "of_us_apps__c", precision: 18
    t.decimal "no_of_non_us_patents__c", precision: 18
    t.decimal "no_of_non_us_applications__c", precision: 18
    t.text "key_patent_s_and_claims__c"
    t.string "best_patent_s__c", limit: 765
    t.datetime "earliest_priority__c"
    t.text "legal_notes__c"
    t.text "seller_notes__c"
    t.text "prospect_member_notes__c"
    t.decimal "who_cares__c", precision: 18
    t.decimal "scariness__c", precision: 18
    t.text "summary__c"
    t.string "quick_opinion__c", limit: 255
    t.string "companies_who_care__c", limit: 765
    t.string "ease_of_detection__c", limit: 255
    t.string "quick_recommendation__c", limit: 255
    t.text "analysis_explanation__c"
    t.string "action_item_assigned_to__c", limit: 150
    t.text "analysis_next_steps__c"
    t.string "target_quarter__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "claims_charts_provided__c", limit: 765
    t.string "licensees__c", limit: 765
    t.text "outside_expert_analysis__c"
    t.string "analysis_stage__c", limit: 255
    t.text "portfolio_patents__c"
    t.decimal "yearly_rate_per_contract__c", precision: 8
    t.decimal "manual_back_fee__c", precision: 22, scale: 6
    t.string "report_toggle__c", limit: 5
    t.string "quarter__c", limit: 255
    t.text "industry_relevance__c"
    t.text "last_action__c"
    t.string "confidential_rpx_eyes_only__c", limit: 5
    t.string "degree_of_dialogue__c", limit: 255
    t.string "deal_probability__c", limit: 255
    t.text "confidential_working_notes__c"
    t.string "confidentiality_level__c", limit: 255
    t.string "send_update_notifications__c", limit: 255
    t.string "verbose_notifications__c", limit: 255
    t.decimal "actual_back_fee__c", precision: 22, scale: 6
    t.decimal "actual_member_payment_back_fee", precision: 22, scale: 6
    t.decimal "actual_rate__c", precision: 22, scale: 6
    t.decimal "amortization_period__c", precision: 2
    t.decimal "calculated_back_fees__c", precision: 22, scale: 6
    t.decimal "discount_amount__c", precision: 22, scale: 6
    t.decimal "discount_full_hidden__c", precision: 18, scale: 15
    t.decimal "rpx_rate_card_from_account__c", precision: 22, scale: 6
    t.decimal "rpx_rate_card_at_deal_close__c", precision: 22, scale: 6
    t.text "rate_details__c"
    t.string "rpx_busdev_priority__c", limit: 255
    t.string "previous_action__c", limit: 765
    t.string "rejected_deal_primary_reason", limit: 255
    t.text "rejected_deal_secondary_reason"
    t.string "top_prospect__c", limit: 5
    t.string "aon_commission__c", limit: 255
    t.decimal "current_vesting_period__c", precision: 2
    t.decimal "membership_term__c", precision: 2
    t.text "win_loss_code__c"
    t.string "yearly_back_fee_override__c", limit: 5
    t.string "company_participation_status", limit: 255
    t.string "rpx_opportunityid__c", limit: 90
    t.datetime "purchase_date__c"
    t.text "comments__c"
    t.string "equity_type__c", limit: 255
    t.string "named_attorney_1__c", limit: 18
    t.string "named_attorney_2__c", limit: 18
    t.string "named_attorney_3__c", limit: 18
    t.string "named_attorney_4__c", limit: 18
    t.string "named_law_firm_1__c", limit: 18
    t.string "named_law_firm_2__c", limit: 18
    t.string "named_law_firm_3__c", limit: 18
    t.string "named_law_firm_4__c", limit: 18
    t.string "patents_in_suit__c", limit: 18
    t.string "datapoints__c", limit: 765
    t.text "rpx_relationship__c"
    t.text "account_s_primary_market_secto"
    t.string "rpx_administrator__c", limit: 18
    t.string "rpx_facilitator__c", limit: 18
    t.string "suit_ranking__c", limit: 255
    t.string "analysis_requested__c", limit: 5
    t.string "candidate_for_syndication__c", limit: 5
    t.string "characterization_of_claims__c", limit: 765
    t.text "claim_terms_and_construction"
    t.string "claims_previously_construed__c", limit: 5
    t.string "claims_previously_held_invalid", limit: 5
    t.string "deal_type__c", limit: 255
    t.datetime "expiration_date__c"
    t.text "licensing_and_ownership_histor"
    t.text "overview_of_prior_art_and_sour"
    t.string "rights_type__c", limit: 255
    t.text "litigation_forecast__c"
    t.string "dataroom_required__c", limit: 255
    t.decimal "account_s_current_revenue__c", precision: 18
    t.string "licensing_advisor__c", limit: 18
    t.datetime "analysis_completed__c"
    t.string "previous_analysis_notes__c", limit: 765
    t.string "standards_based__c", limit: 5
    t.string "market_sector_detail__c", limit: 255
    t.datetime "analysis_start_date__c"
    t.string "contingent_payment_obligations", limit: 255
    t.string "finders_fee_commission_payment", limit: 255
    t.string "field_of_use_limitations__c", limit: 255
    t.string "future_incentive_payments_to_p", limit: 255
    t.string "client_specific_exclusions__c", limit: 255
    t.string "other_non_standard_provisions", limit: 255
    t.string "contingency_payment_detail__c", limit: 765
    t.string "finders_fee_commission_detail", limit: 765
    t.string "field_of_use_limitation_detail", limit: 765
    t.string "future_incentive_payments_deta", limit: 765
    t.string "client_specific_exlusions_deta", limit: 765
    t.string "other_non_standard_provision0", limit: 765
    t.string "litigation_history__c", limit: 765
    t.decimal "amortization_period_renewal__c", precision: 3
    t.decimal "annual_member_payment__c", precision: 24, scale: 6
    t.decimal "avoided_cost_000s__c", precision: 16, scale: 6
    t.decimal "current_roi_prorated__c", precision: 5
    t.decimal "current_roi__c", precision: 5
    t.datetime "current_term_effective_date__c"
    t.datetime "current_term_expiration_date"
    t.decimal "current_term__c", precision: 2
    t.string "heat_map__c", limit: 255
    t.datetime "initial_effective_date__c"
    t.decimal "initial_term__c", precision: 2
    t.datetime "new_term_effective_date__c"
    t.text "notes__c"
    t.decimal "notification_term_for_non_rene", precision: 3
    t.string "payment_schedule__c", limit: 255
    t.decimal "proposed_new_term_yrs__c", precision: 3
    t.text "publicity_rights_exception__c"
    t.string "roi_last_updated__c", limit: 765
    t.decimal "yearly_back_fee__c", precision: 16, scale: 6
    t.string "call_schedule__c", limit: 255
    t.string "prioritization__c", limit: 255
    t.datetime "date_roi_confirmed__c"
    t.string "roi_confirmed__c", limit: 255
    t.string "previous_invoice_amounts__c", limit: 765
    t.string "system_rate_last_updated__c", limit: 150
    t.text "close_quarter__c"
    t.string "lid__linkedin_company_id__c", limit: 240
    t.string "hub_opportunity__c", limit: 18
    t.decimal "of_us_patents_input__c", precision: 10
    t.string "close_driver__c", limit: 255
    t.decimal "no_of_non_us_patents_input__c", precision: 10
    t.decimal "no_of_non_us_applications_inpu", precision: 18
    t.decimal "no_of_us_applications_input__c", precision: 10
    t.string "contact1__c", limit: 18
    t.string "identified_litigation__c", limit: 300
    t.string "current_status_sa__c", limit: 765
    t.string "opportunity_source__c", limit: 255
    t.string "explored_ip_insurance_before", limit: 255
    t.decimal "proposed_vesting_period__c", precision: 2
    t.text "explored_terms__c"
    t.string "budgeting_cycle__c", limit: 255
    t.string "flexibility_with_broker_cycle", limit: 255
    t.decimal "insurance_budget__c", precision: 24, scale: 6
    t.string "insurance_purchasor__c", limit: 255
    t.string "contingent_on_litigation__c", limit: 255
    t.decimal "per_claim_retention__c", precision: 24, scale: 6
    t.decimal "co_pay__c", precision: 3
    t.decimal "per_claim_limit__c", precision: 24, scale: 6
    t.decimal "aggregate_limit__c", precision: 24, scale: 6
    t.decimal "actual_member_payment__c", precision: 22, scale: 6
    t.decimal "aggregate_retention__c", precision: 24, scale: 6
    t.string "corporate_insurance_broker__c", limit: 255
    t.text "insurance_win_loss_code__c"
    t.text "litigation_details__c"
    t.text "system_rate_last_updated_1__c"
    t.string "special_provisions__c", limit: 765
    t.string "dataroom_created__c", limit: 255
    t.string "can_share_name__c", limit: 255
    t.string "anonymous_plaintiff__c", limit: 255
    t.string "attached_all_relevant_sales_ma", limit: 5
    t.datetime "automatic_roi_last_updated__c"
    t.datetime "contracteffectivedate__c"
    t.decimal "contract_roi__c", precision: 18
    t.string "hub_acquisition__c", limit: 18
    t.text "heat_map_color__c"
    t.decimal "invoiced_roi__c", precision: 18
    t.decimal "last_12_months_roi__c", precision: 18
    t.decimal "prorated_roi__c", precision: 18
    t.text "recordtype__c"
    t.string "specified_publicity_on_account", limit: 5
    t.string "dataroom_expected__c", limit: 255
    t.string "corresponding_acquisition_id", limit: 54
    t.string "close_date_change_reason__c", limit: 255
    t.string "close_date_change_comments__c", limit: 765
    t.decimal "annual_premium__c", precision: 24, scale: 6
    t.decimal "bundle_discount__c", precision: 24, scale: 6
    t.decimal "annual_rpx_membership_fee__c", precision: 24, scale: 6
    t.decimal "pricing_subtotal__c", precision: 22, scale: 6
    t.decimal "rrg_investment__c", precision: 24, scale: 6
    t.decimal "total_fee__c", precision: 24, scale: 6
    t.string "close_driver_comments__c", limit: 765
    t.string "dormant_code__c", limit: 255
    t.datetime "date_quoted__c"
    t.decimal "bundle_discount_percent__c", precision: 18, scale: 1
    t.decimal "upsell_rate__c", precision: 24, scale: 6
    t.string "next_steps__c", limit: 765
    t.decimal "net_membership_fee__c", precision: 24, scale: 6
    t.string "next_underwriting_milestone__c", limit: 255
    t.datetime "need_by__c"
    t.string "presentation_required__c", limit: 255
    t.text "comments_for_underwriters__c"
    t.string "tech_related_lits__c", limit: 5
    t.text "tech_related_lit_s_list__c"
    t.string "tech_related_lits_updated__c", limit: 300
    t.string "cr_cd_action_items__c", limit: 765
    t.string "potential_rpx_benefit__c", limit: 765
    t.string "aon_primary_contact__c", limit: 18
    t.string "aon_primary_contact_role__c", limit: 255
    t.datetime "date_of_aon_approval__c"
    t.datetime "expiration_of_aon_approval__c"
    t.string "aon_contact_2__c", limit: 18
    t.string "aon_contact_3__c", limit: 18
    t.string "aon_contact_2_role__c", limit: 255
    t.string "aon_contact_3_role__c", limit: 255
    t.string "deal_comments__c", limit: 765
    t.text "term_expiration_quarter__c"
    t.string "aon_introduction_made__c", limit: 255
    t.datetime "date_of_aon_intro_meeting__c"
    t.text "rate_card__c"
    t.decimal "standard_2013_rate__c", precision: 22, scale: 6
    t.decimal "risk_based_price_discount__c", precision: 18, scale: 2
    t.datetime "risk_based_price_expiration_da"
    t.decimal "option_fee__c", precision: 16, scale: 6
    t.decimal "option_cost_to_rpx__c", precision: 16, scale: 6
    t.string "benchmarking_type__c", limit: 255
  end

  create_table "ds_2704_acquisition_patents_dcl", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "acquisition_patent_id"
    t.integer "acquisition_id"
    t.integer "portfolio_id"
    t.string "patnum", limit: 255
    t.string "stripped_patnum", limit: 32
    t.string "country_code", limit: 8
    t.string "application_number", limit: 50
    t.integer "rpx_ownership_right_id"
    t.date "expiration_date"
    t.date "publication_date"
    t.string "publication_number", limit: 50
    t.string "case_number", limit: 50
    t.integer "asset_status_type_id"
    t.integer "cpi_tracking_status_id"
    t.datetime "cpi_tracking_date"
    t.boolean "is_asset_matched"
    t.string "asset_source", limit: 1
    t.integer "asset_source_id"
    t.text "title"
    t.date "issue_date"
    t.date "priority_date"
    t.boolean "is_application"
    t.text "current_assignees"
    t.integer "pat_family_id"
    t.date "filing_date"
    t.date "annuity_payment_date"
    t.boolean "terminal_disclaimer"
    t.integer "number_of_claims"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.integer "created_by_user_id"
    t.integer "updated_by_user_id"
  end

  create_table "ds_4112_user_notifications", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "notifiable_id"
    t.integer "user_id"
    t.boolean "is_read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.string "notifiable_type", limit: 255
  end

  create_table "ds_4264_license_date_update", id: false, force: :cascade do |t|
    t.integer "member_credit_id"
    t.string "mc_entity_name"
    t.string "mc_entity_sf_acct_type"
    t.string "portfolio_name"
    t.date "portfolio_acquisition_date"
    t.date "old_license_date"
    t.date "new_license_date"
    t.integer "review"
  end

  create_table "ds_4275_license_date_update", id: false, force: :cascade do |t|
    t.integer "member_credit_id"
    t.string "mc_entity_name"
    t.string "portfolio_name"
    t.date "portfolio_acquisition_date"
    t.date "old_license_date"
    t.date "new_license_date"
    t.integer "diff"
  end

  create_table "ds_4457_acquisition_syndications", id: false, force: :cascade do |t|
    t.string "acquisition_name"
    t.integer "acquisition_id"
    t.string "entity_name"
    t.string "entity_sf_account_id"
    t.string "additional_contribution"
    t.string "notes"
  end

  create_table "ds_4862_acquisition_opportunity__c", id: false, force: :cascade do |t|
    t.integer "etl_id"
    t.string "delete_flag", limit: 1
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.string "recordtypeid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.text "accountid__c"
    t.string "account__c", limit: 18
    t.string "action_item_assigned_to__c", limit: 150
    t.decimal "amount_for_pipeline__c", precision: 22, scale: 6
    t.string "analysis_assigned_to__c", limit: 18
    t.datetime "analysis_completed__c"
    t.text "analysis_next_steps__c"
    t.text "analysis_notes__c"
    t.text "analysis_recommendation__c"
    t.string "analysis_requested__c", limit: 5
    t.string "analysis_stage__c", limit: 255
    t.datetime "analysis_start_date__c"
    t.text "analysis_explanation__c"
    t.string "assets__c", limit: 18
    t.string "best_patent_s__c", limit: 765
    t.datetime "bids_due__c"
    t.decimal "brokersopeningoffer__c", precision: 22, scale: 6
    t.string "campaign__c", limit: 18
    t.text "characterization_of_claims__c"
    t.string "claims_previously_held_invalid", limit: 5
    t.string "claims_charts_provided__c", limit: 765
    t.string "clonedfrom__c", limit: 18
    t.datetime "closedate__c"
    t.text "close_quarter__c"
    t.string "closed_lost_primary_reason_lit", limit: 255
    t.text "closed_lost_secondary_reason_l"
    t.text "comments__c"
    t.string "relevant_industries__c", limit: 765
    t.string "confidentiality_level__c", limit: 255
    t.string "contact1__c", limit: 18
    t.datetime "contracteffectivedate__c"
    t.string "current_status_sa__c", limit: 765
    t.text "current_status__c"
    t.text "deal_notes__c"
    t.string "deal_probability__c", limit: 255
    t.text "deal_summary__c"
    t.string "degree_of_dialogue__c", limit: 255
    t.text "description__c"
    t.text "detection__c"
    t.datetime "due_date__c"
    t.datetime "earliest_priority__c"
    t.text "enforcement_review__c"
    t.text "executive_summary__c"
    t.datetime "expiration_date__c"
    t.text "file_history_review__c"
    t.string "forecastcategoryname__c", limit: 255
    t.datetime "free_option_expiration_date__c"
    t.string "free_option_notes__c", limit: 765
    t.decimal "free_options_negotiated__c", precision: 16
    t.decimal "free_options_remaining__c", precision: 18
    t.decimal "free_options_used__c", precision: 16
    t.string "isprivate__c", limit: 5
    t.text "key_claim_s__c"
    t.text "key_patent_s_and_claims__c"
    t.text "last_action__c"
    t.string "leadsource__c", limit: 255
    t.string "legacyopportunityid__c", limit: 54
    t.text "legal_notes__c"
    t.string "licensee_scratchpad__c", limit: 765
    t.text "licensing_and_ownership_histor"
    t.text "litigation_forecast__c"
    t.string "litigation_history__c", limit: 765
    t.string "nda__c", limit: 5
    t.string "nextstep__c", limit: 765
    t.decimal "no_of_non_us_applications_inpu", precision: 18
    t.decimal "no_of_non_us_applications_roll", precision: 18
    t.decimal "no_of_non_us_patents_input__c", precision: 10
    t.decimal "no_of_non_us_patents_roll_up", precision: 18
    t.decimal "no_of_us_applications_input__c", precision: 10
    t.decimal "no_of_us_applications_roll_up", precision: 18
    t.decimal "no_of_us_patents_roll_up__c", precision: 18
    t.text "non_us_patent_application__c"
    t.text "non_us_patent_numbers__c"
    t.text "notes__c"
    t.text "other_research_notes__c"
    t.text "outside_expert_analysis__c"
    t.text "patent_portfolio_summary__c"
    t.string "patents_in_suit__c", limit: 18
    t.text "phase_0_comments__c"
    t.text "portfolio_patents__c"
    t.string "previous_analysis_notes__c", limit: 765
    t.string "primary_market_sector__c", limit: 255
    t.text "priority_research__c"
    t.string "priority__c", limit: 255
    t.text "private_deal_notes__c"
    t.string "probability__c", limit: 255
    t.text "prospect_member_notes__c"
    t.datetime "purchase_date__c"
    t.string "quarter__c", limit: 255
    t.string "quick_opinion__c", limit: 255
    t.string "quick_recommendation__c", limit: 255
    t.string "rpx_opportunityid__c", limit: 90
    t.decimal "rpxsopeningoffer__c", precision: 22, scale: 6
    t.text "record_type_text__c"
    t.string "rejected_deal_primary_reason", limit: 255
    t.text "rejected_deal_secondary_reason"
    t.string "report_toggle__c", limit: 5
    t.text "representative_claims__c"
    t.text "sme_review__c"
    t.decimal "scariness__c", precision: 18
    t.string "seller_loop_closed__c", limit: 5
    t.text "seller_notes__c"
    t.text "seller_research__c"
    t.string "seller_claims_charts__c", limit: 5
    t.string "sellersexplicitexpectation__c", limit: 300
    t.string "send_update_notifications__c", limit: 255
    t.string "source__c", limit: 18
    t.text "spec_support__c"
    t.string "stagename__c", limit: 255
    t.datetime "start_date__c"
    t.string "suit_ranking__c", limit: 255
    t.text "summary__c"
    t.datetime "summary_fields_updated__c"
    t.text "technology_area__c"
    t.text "theories_of_relevance__c"
    t.decimal "totalopportunityquantity__c", precision: 18, scale: 2
    t.text "triage_comments__c"
    t.string "type__c", limit: 255
    t.text "us_application_numbers__c"
    t.string "verbose_notifications__c", limit: 255
    t.decimal "who_cares__c", precision: 18
    t.string "rpx_project_code__c", limit: 90
    t.decimal "no_of_us_patents__c", precision: 18
    t.text "legacy_broadest_independent_cl"
    t.text "legacy_characterization_of_cla"
    t.text "legacy_confidential_working_no"
    t.text "legacy_summary__c"
    t.text "assigned_analyst_is_current_us"
    t.string "rights_type__c", limit: 255
    t.datetime "date_filter__c"
    t.string "of_patents_manual_entry__c", limit: 120
    t.string "asset_source_type__c", limit: 255
    t.datetime "public_deal_notes_updated_by_a"
    t.datetime "last_action_updated_by_acq__c"
    t.datetime "next_step_updated_by_acq__c"
    t.datetime "seller_s_expectation_updated_b"
    t.datetime "last_significant_update_by_acq"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.decimal "count__c", precision: 18
    t.decimal "n_defendants_active__c", precision: 18
    t.decimal "n_defendants_terminated__c", precision: 18
    t.decimal "n_defendants__c", precision: 18
    t.decimal "n_members_active__c", precision: 18
    t.decimal "n_members_terminated__c", precision: 18
    t.decimal "n_members__c", precision: 18
    t.decimal "n_prospects_active__c", precision: 18
    t.decimal "n_prospects_terminated__c", precision: 18
    t.decimal "n_prospects__c", precision: 18
    t.string "refresh__c", limit: 5
    t.string "member_credit_portfolio_descri", limit: 300
    t.string "deal_team_1__c", limit: 18
    t.string "deal_team_2__c", limit: 18
    t.string "deal_team_3__c", limit: 18
    t.string "cr_cd_action_items__c", limit: 765
    t.string "potential_rpx_benefit__c", limit: 765
    t.string "npe_offer__c", limit: 5
    t.string "asset_owner__c", limit: 18
    t.text "marketing_bullets__c"
    t.string "patent_ncs__c", limit: 255
    t.text "days_since_next_step_updated"
    t.string "acquisition_name__c", limit: 240
    t.text "comparables__c"
    t.string "notice_waiver__c", limit: 5
    t.string "name_copy_unique__c", limit: 240
    t.string "direct_notice_waiver__c", limit: 5
    t.string "color_code__c", limit: 3
    t.text "pa_documents_reviewed__c"
    t.string "sector_representative__c", limit: 18
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.decimal "no_of_non_party_entity_records", precision: 18
    t.decimal "no_of_non_party_entity_record0", precision: 18
    t.decimal "no_of_non_party_entity_record1", precision: 18
    t.decimal "no_of_non_party_entity_record2", precision: 18
    t.string "most_recent_valuation_tracking", limit: 18
    t.datetime "valuation_date__c"
    t.string "intent_to_litigate__c", limit: 5
    t.datetime "nda_expiration_date__c"
    t.string "fee__c", limit: 5
    t.string "timeline__c", limit: 765
    t.string "hold_reasons__c", limit: 255
    t.string "seller_s_expectation_an_estima", limit: 5
    t.string "most_recent_valuation_trackin0", limit: 18
    t.datetime "valuation_date_guidance__c"
    t.string "new_net_revenue_gross_margin_e", limit: 60
    t.string "insight_id__c", limit: 240
    t.datetime "insight_updated_time__c"
    t.text "amount_for_pipeline_notes__c"
    t.text "seller_s_explicit_expectation"
    t.string "brief_technology_description", limit: 255
    t.string "validity_notes__c", limit: 140
    t.string "most_recent_valuation_trackin1", limit: 18
    t.datetime "valuation_date_bid__c"
  end

  create_table "ds_4862_opportunity", id: false, force: :cascade do |t|
    t.integer "etl_id"
    t.string "delete_flag", limit: 1
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "accountid", limit: 18
    t.string "recordtypeid", limit: 18
    t.string "isprivate", limit: 5
    t.string "namex", limit: 360
    t.text "description"
    t.string "stagename", limit: 255
    t.decimal "amount", precision: 22, scale: 6
    t.decimal "probability", precision: 3
    t.decimal "expectedrevenue", precision: 22, scale: 6
    t.decimal "totalopportunityquantity", precision: 18, scale: 2
    t.datetime "closedate"
    t.string "typex", limit: 255
    t.string "nextstep", limit: 765
    t.string "leadsource", limit: 255
    t.string "isclosed", limit: 5
    t.string "iswon", limit: 5
    t.string "forecastcategory", limit: 255
    t.string "forecastcategoryname", limit: 255
    t.string "currencyisocode", limit: 255
    t.string "campaignid", limit: 18
    t.string "hasopportunitylineitem", limit: 5
    t.string "pricebook2id", limit: 18
    t.string "ownerid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.decimal "fiscalquarter"
    t.decimal "fiscalyear"
    t.string "fiscal", limit: 6
    t.string "opportunity_type__c", limit: 255
    t.string "litigation__c", limit: 18
    t.decimal "discount__c", precision: 5, scale: 2
    t.text "private_deal_notes__c"
    t.decimal "historical_rate__c", precision: 24, scale: 6
    t.string "priority__c", limit: 255
    t.text "analysis_notes__c"
    t.text "deal_notes__c"
    t.datetime "bids_due__c"
    t.string "assets__c", limit: 18
    t.string "lead_source_2__c", limit: 180
    t.text "triage_comments__c"
    t.string "source_del__c", limit: 18
    t.string "seller_claims_charts__c", limit: 5
    t.text "current_status__c"
    t.text "portfolio_summary__c"
    t.datetime "start_date__c"
    t.string "seller_loop_closed__c", limit: 5
    t.text "analysis_recommendation__c"
    t.string "seller_s_expectation__c", limit: 300
    t.string "nda__c", limit: 5
    t.string "outside_analysis__c", limit: 150
    t.text "deal_summary__c"
    t.decimal "rpx_rate__c", precision: 21, scale: 6
    t.string "sales_materials_sent__c", limit: 765
    t.datetime "due_date__c"
    t.text "technology_area__c"
    t.string "rpx_project_code__c", limit: 90
    t.string "analysis_assigned_to__c", limit: 18
    t.text "key_patent_s_and_claims__c"
    t.string "best_patent_s__c", limit: 765
    t.datetime "earliest_priority__c"
    t.text "legal_notes__c"
    t.text "seller_notes__c"
    t.text "prospect_member_notes__c"
    t.decimal "who_cares__c", precision: 18
    t.decimal "scariness__c", precision: 18
    t.text "summary__c"
    t.string "quick_opinion__c", limit: 255
    t.string "companies_who_care__c", limit: 765
    t.string "ease_of_detection__c", limit: 255
    t.string "quick_recommendation__c", limit: 255
    t.text "analysis_explanation__c"
    t.string "action_item_assigned_to__c", limit: 150
    t.text "analysis_next_steps__c"
    t.string "target_quarter__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "claims_charts_provided__c", limit: 765
    t.string "licensees__c", limit: 765
    t.text "outside_expert_analysis__c"
    t.string "analysis_stage__c", limit: 255
    t.text "portfolio_patents__c"
    t.decimal "yearly_rate_per_contract__c", precision: 8
    t.decimal "manual_back_fee__c", precision: 22, scale: 6
    t.string "report_toggle__c", limit: 5
    t.string "quarter__c", limit: 255
    t.text "industry_relevance__c"
    t.text "last_action__c"
    t.string "confidential_rpx_eyes_only__c", limit: 5
    t.string "degree_of_dialogue__c", limit: 255
    t.string "deal_probability__c", limit: 255
    t.text "confidential_working_notes__c"
    t.string "confidentiality_level__c", limit: 255
    t.string "send_update_notifications__c", limit: 255
    t.string "verbose_notifications__c", limit: 255
    t.decimal "actual_back_fee__c", precision: 22, scale: 6
    t.decimal "actual_member_payment_back_fee", precision: 22, scale: 6
    t.decimal "actual_rate__c", precision: 22, scale: 6
    t.decimal "amortization_period__c", precision: 2
    t.decimal "calculated_back_fees__c", precision: 22, scale: 6
    t.decimal "discount_amount__c", precision: 22, scale: 6
    t.decimal "discount_full_hidden__c", precision: 18, scale: 15
    t.decimal "rpx_rate_card_from_account__c", precision: 22, scale: 6
    t.decimal "rpx_rate_card_at_deal_close__c", precision: 22, scale: 6
    t.text "rate_details__c"
    t.string "rpx_busdev_priority__c", limit: 255
    t.string "previous_action__c", limit: 765
    t.string "rejected_deal_primary_reason", limit: 255
    t.text "rejected_deal_secondary_reason"
    t.string "top_prospect__c", limit: 5
    t.string "aon_commission__c", limit: 255
    t.decimal "current_vesting_period__c", precision: 2
    t.decimal "membership_term__c", precision: 2
    t.text "win_loss_code__c"
    t.string "yearly_back_fee_override__c", limit: 5
    t.string "company_participation_status", limit: 255
    t.string "rpx_opportunityid__c", limit: 90
    t.datetime "purchase_date__c"
    t.text "comments__c"
    t.string "equity_type__c", limit: 255
    t.string "named_attorney_1__c", limit: 18
    t.string "named_attorney_2__c", limit: 18
    t.string "named_attorney_3__c", limit: 18
    t.string "named_attorney_4__c", limit: 18
    t.string "aon_contact_2__c", limit: 18
    t.string "named_law_firm_1__c", limit: 18
    t.string "named_law_firm_2__c", limit: 18
    t.string "named_law_firm_3__c", limit: 18
    t.string "named_law_firm_4__c", limit: 18
    t.string "aon_contact_3__c", limit: 18
    t.string "aon_contact_2_role__c", limit: 255
    t.string "aon_contact_3_role__c", limit: 255
    t.string "deal_comments__c", limit: 765
    t.text "term_expiration_quarter__c"
    t.string "aon_introduction_made__c", limit: 255
    t.string "patents_in_suit__c", limit: 18
    t.string "datapoints__c", limit: 765
    t.text "rpx_relationship__c"
    t.text "account_s_primary_market_secto"
    t.string "rpx_administrator__c", limit: 18
    t.string "rpx_facilitator__c", limit: 18
    t.datetime "date_of_aon_intro_meeting__c"
    t.string "suit_ranking__c", limit: 255
    t.string "analysis_requested__c", limit: 5
    t.string "candidate_for_syndication__c", limit: 5
    t.string "characterization_of_claims__c", limit: 765
    t.text "claim_terms_and_construction"
    t.string "claims_previously_construed__c", limit: 5
    t.string "claims_previously_held_invalid", limit: 5
    t.string "deal_type__c", limit: 255
    t.datetime "expiration_date__c"
    t.text "licensing_and_ownership_histor"
    t.text "overview_of_prior_art_and_sour"
    t.string "rights_type__c", limit: 255
    t.text "litigation_forecast__c"
    t.string "dataroom_required__c", limit: 255
    t.decimal "account_s_current_revenue__c", precision: 18
    t.string "licensing_advisor__c", limit: 18
    t.datetime "analysis_completed__c"
    t.string "previous_analysis_notes__c", limit: 765
    t.string "standards_based__c", limit: 5
    t.string "market_sector_detail__c", limit: 255
    t.datetime "analysis_start_date__c"
    t.string "contingent_payment_obligations", limit: 255
    t.string "finders_fee_commission_payment", limit: 255
    t.string "field_of_use_limitations__c", limit: 255
    t.string "future_incentive_payments_to_p", limit: 255
    t.string "client_specific_exclusions__c", limit: 255
    t.string "other_non_standard_provisions", limit: 255
    t.string "contingency_payment_detail__c", limit: 765
    t.string "finders_fee_commission_detail", limit: 765
    t.string "field_of_use_limitation_detail", limit: 765
    t.string "future_incentive_payments_deta", limit: 765
    t.string "client_specific_exlusions_deta", limit: 765
    t.string "other_non_standard_provision0", limit: 765
    t.string "litigation_history__c", limit: 765
    t.decimal "amortization_period_renewal__c", precision: 3
    t.decimal "annual_member_payment__c", precision: 24, scale: 6
    t.decimal "avoided_cost_000s__c", precision: 16, scale: 6
    t.decimal "current_roi_prorated__c", precision: 5
    t.decimal "current_roi__c", precision: 5
    t.datetime "current_term_effective_date__c"
    t.datetime "current_term_expiration_date"
    t.decimal "current_term__c", precision: 2
    t.string "heat_map__c", limit: 255
    t.datetime "initial_effective_date__c"
    t.decimal "initial_term__c", precision: 2
    t.datetime "new_term_effective_date__c"
    t.text "notes__c"
    t.decimal "notification_term_for_non_rene", precision: 3
    t.string "payment_schedule__c", limit: 255
    t.decimal "proposed_new_term_yrs__c", precision: 3
    t.text "publicity_rights_exception__c"
    t.string "roi_last_updated__c", limit: 765
    t.decimal "yearly_back_fee__c", precision: 16, scale: 6
    t.string "call_schedule__c", limit: 255
    t.string "prioritization__c", limit: 255
    t.datetime "date_roi_confirmed__c"
    t.string "roi_confirmed__c", limit: 255
    t.string "previous_invoice_amounts__c", limit: 765
    t.string "system_rate_last_updated__c", limit: 150
    t.text "close_quarter__c"
    t.string "lid__linkedin_company_id__c", limit: 240
    t.string "hub_opportunity__c", limit: 18
    t.decimal "of_us_patents_input__c", precision: 10
    t.string "close_driver__c", limit: 255
    t.decimal "no_of_non_us_patents_input__c", precision: 10
    t.decimal "no_of_non_us_applications_inpu", precision: 18
    t.decimal "no_of_us_applications_input__c", precision: 10
    t.string "contact1__c", limit: 18
    t.string "identified_litigation__c", limit: 300
    t.string "current_status_sa__c", limit: 765
    t.string "opportunity_source__c", limit: 255
    t.string "explored_ip_insurance_before", limit: 255
    t.decimal "proposed_vesting_period__c", precision: 2
    t.text "explored_terms__c"
    t.string "budgeting_cycle__c", limit: 255
    t.string "flexibility_with_broker_cycle", limit: 255
    t.decimal "insurance_budget__c", precision: 24, scale: 6
    t.string "insurance_purchasor__c", limit: 255
    t.text "rate_card__c"
    t.decimal "standard_2013_rate__c", precision: 22, scale: 6
    t.string "contingent_on_litigation__c", limit: 255
    t.decimal "per_claim_retention__c", precision: 24, scale: 6
    t.decimal "co_pay__c", precision: 3
    t.decimal "per_claim_limit__c", precision: 24, scale: 6
    t.decimal "aggregate_limit__c", precision: 24, scale: 6
    t.decimal "actual_member_payment__c", precision: 22, scale: 6
    t.decimal "risk_based_price_discount__c", precision: 18, scale: 2
    t.datetime "risk_based_price_expiration_da"
    t.decimal "aggregate_retention__c", precision: 24, scale: 6
    t.string "corporate_insurance_broker__c", limit: 255
    t.text "insurance_win_loss_code__c"
    t.text "litigation_details__c"
    t.text "system_rate_last_updated_1__c"
    t.string "special_provisions__c", limit: 765
    t.string "dataroom_created__c", limit: 255
    t.string "can_share_name__c", limit: 255
    t.string "anonymous_plaintiff__c", limit: 255
    t.string "attached_all_relevant_sales_ma", limit: 5
    t.datetime "automatic_roi_last_updated__c"
    t.datetime "contracteffectivedate__c"
    t.decimal "contract_roi__c", precision: 18
    t.string "hub_acquisition__c", limit: 18
    t.text "heat_map_color__c"
    t.decimal "invoiced_roi__c", precision: 18
    t.decimal "last_12_months_roi__c", precision: 18
    t.decimal "prorated_roi__c", precision: 18
    t.text "recordtype__c"
    t.string "specified_publicity_on_account", limit: 5
    t.string "dataroom_expected__c", limit: 255
    t.string "corresponding_acquisition_id", limit: 54
    t.string "close_date_change_reason__c", limit: 255
    t.string "close_date_change_comments__c", limit: 765
    t.decimal "annual_premium__c", precision: 24, scale: 6
    t.decimal "option_fee__c", precision: 16, scale: 6
    t.decimal "bundle_discount__c", precision: 24, scale: 6
    t.decimal "annual_rpx_membership_fee__c", precision: 24, scale: 6
    t.decimal "pricing_subtotal__c", precision: 22, scale: 6
    t.decimal "rrg_investment__c", precision: 24, scale: 6
    t.decimal "total_fee__c", precision: 24, scale: 6
    t.string "close_driver_comments__c", limit: 765
    t.string "dormant_code__c", limit: 255
    t.datetime "date_quoted__c"
    t.decimal "bundle_discount_percent__c", precision: 18, scale: 1
    t.decimal "upsell_rate__c", precision: 24, scale: 6
    t.string "next_steps__c", limit: 765
    t.decimal "net_membership_fee__c", precision: 24, scale: 6
    t.string "next_underwriting_milestone__c", limit: 255
    t.datetime "need_by__c"
    t.string "presentation_required__c", limit: 255
    t.text "comments_for_underwriters__c"
    t.string "tech_related_lits__c", limit: 5
    t.text "tech_related_lit_s_list__c"
    t.decimal "option_cost_to_rpx__c", precision: 16, scale: 6
    t.string "tech_related_lits_updated__c", limit: 300
    t.string "cr_cd_action_items__c", limit: 765
    t.string "potential_rpx_benefit__c", limit: 765
    t.string "aon_primary_contact__c", limit: 18
    t.string "aon_primary_contact_role__c", limit: 255
    t.datetime "date_of_aon_approval__c"
    t.datetime "expiration_of_aon_approval__c"
    t.string "benchmarking_type__c", limit: 255
    t.text "roi_notes__c"
    t.datetime "roi_last_presented__c"
    t.string "client_portal__c", limit: 7
    t.string "litigation_clearance__c", limit: 7
    t.string "roi__c", limit: 7
    t.string "open_market_acq_s__c", limit: 7
    t.string "syndications__c", limit: 7
    t.string "intelligence__c", limit: 7
    t.string "conferences__c", limit: 7
    t.string "networking__c", limit: 7
    t.string "insurance__c", limit: 7
    t.string "collaborative_defense__c", limit: 7
    t.string "entertainment__c", limit: 7
    t.string "defensive_option__c", limit: 7
    t.string "vesting_option__c", limit: 5
    t.string "other_value_drivers__c", limit: 765
    t.text "hot_buttons_sensitivities__c"
    t.string "feedback_for_oma__c", limit: 5
    t.string "feedback_for_lits__c", limit: 5
    t.string "is_feedback_timely__c", limit: 5
    t.string "feedback_obtainability_notes", limit: 765
    t.text "list_of_troubling_issues__c"
    t.text "plan_to_resolve_issues__c"
    t.text "resources_needed_for_resolutio"
    t.text "member_s_approval_process__c"
    t.text "plan_to_get_to_decision_makers"
    t.text "current_relationship_status__c"
    t.string "policy_type__c", limit: 255
    t.string "vesting__c", limit: 255
    t.decimal "weighted_rate__c", precision: 22, scale: 6
    t.decimal "lits_filed_this_year", precision: 18
    t.decimal "lits_filed_this_past_year", precision: 18
    t.decimal "lits_filed_past_5_years_active", precision: 18
    t.string "underwriter__c", limit: 255
    t.datetime "next_step_last_mod__c"
    t.text "support_team_engaged__c"
    t.string "contact_2__c", limit: 18
    t.string "contact_3__c", limit: 18
    t.string "contact_2_role__c", limit: 255
    t.string "contact_3_role__c", limit: 255
    t.string "primary_contact__c", limit: 18
    t.string "primary_contact_role__c", limit: 255
    t.decimal "most_recent_annual_fee__c", precision: 24, scale: 6
    t.decimal "priority_tier__c", precision: 18
    t.decimal "prospect_score__c", precision: 18
    t.string "est_rate_floor__c", limit: 765
    t.datetime "est_rate_floor_last_modified"
    t.decimal "outreach_tier__c", precision: 1
    t.string "materials_presented__c", limit: 255
    t.string "agreement_sent__c", limit: 255
    t.string "participant_contact__c", limit: 120
    t.datetime "last_date_contacted__c"
    t.decimal "standard_2014_rate__c", precision: 22, scale: 6
    t.string "patent_prior_art__c", limit: 255
    t.string "related_litigation__c", limit: 255
    t.string "other_restrictions__c", limit: 765
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "ip_team_size__c", limit: 255
    t.string "ip_team_description__c", limit: 765
    t.string "introduction_made__c", limit: 255
    t.datetime "date_of_intro_meeting__c"
    t.datetime "date_of_approval__c"
    t.datetime "expiration_of_approval__c"
    t.string "broker_partner_account__c", limit: 18
    t.string "broker_partner_type__c", limit: 255
    t.string "original_source__c", limit: 255
    t.string "engagement_begun__c", limit: 255
    t.string "competing_bids__c", limit: 255
    t.string "broker_contact__c", limit: 18
    t.text "tier_type__c"
    t.string "pricing_indication__c", limit: 255
    t.string "underwriterlookup__c", limit: 18
    t.text "candidate_for__c"
    t.text "local_counsel_venue__c"
    t.decimal "standard_2015_rate__c", precision: 24, scale: 6
    t.string "finc_services_outreach_2015__c", limit: 5
    t.string "excess_outreach_2015__c", limit: 5
    t.string "p1_mem_outreach_2015__c", limit: 5
    t.string "syncedquoteid", limit: 18
    t.datetime "subscription_start_date__c"
    t.datetime "subscription_end_date__c"
    t.datetime "trial_start_date__c"
    t.datetime "trial_end_date__c"
    t.datetime "next_outreach_date__c"
    t.string "subscription_tier__c", limit: 255
  end

  create_table "ds_4862_patent_analysis_request__c", id: false, force: :cascade do |t|
    t.integer "etl_id"
    t.string "delete_flag", limit: 1
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "acquisition_opportunity__c", limit: 18
    t.text "admin_notes__c"
    t.string "analysis_type__c", limit: 255
    t.string "assigned_to__c", limit: 18
    t.datetime "completed_date__c"
    t.datetime "due_date__c"
    t.decimal "hours__c", precision: 5, scale: 1
    t.string "opportunity__c", limit: 18
    t.string "priority__c", limit: 255
    t.decimal "ranking__c", precision: 12, scale: 3
    t.string "request_type__c", limit: 255
    t.text "request__c"
    t.string "requested_by__c", limit: 18
    t.string "sendassignmentnotification__c", limit: 5
    t.string "status__c", limit: 255
    t.text "assigned_to_is_current_user__c"
    t.string "assigned_searcher__c", limit: 18
    t.datetime "vendor_search_due_date__c"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "other_notes__c", limit: 765
    t.string "patent__c", limit: 18
    t.text "patents__c"
    t.string "recordtypeid", limit: 18
    t.string "case_key__c", limit: 255
    t.string "case_name__c", limit: 255
    t.decimal "litigation_id__c", precision: 18
    t.string "notes__c", limit: 255
    t.string "status_prior_art_report__c", limit: 255
    t.text "defendants__c"
    t.string "report_name__c", limit: 40
    t.string "account__c", limit: 18
    t.decimal "campaign_id__c", precision: 18
    t.string "campaign_name__c", limit: 255
    t.string "pasp_id__c", limit: 25
  end

  create_table "ecosystem__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.string "company__c", limit: 18
    t.string "most_recent__c", limit: 5
    t.string "status__c", limit: 255
    t.string "version_name__c", limit: 210
    t.decimal "version__c", precision: 4
    t.string "application__c", limit: 18
    t.datetime "risk_cohort_last_run__c"
    t.index ["id"], name: "uecosystem__c", unique: true
  end

  create_table "ecosystem_detail__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.string "ecosystem__c", limit: 18
    t.string "ecosystem_entity__c", limit: 18
    t.decimal "similarity__c", precision: 7, scale: 2
    t.text "source__c"
    t.string "unique_check__c", limit: 111
    t.text "ecosystem_name__c"
    t.datetime "first_added__c"
    t.string "self_reported__c", limit: 5
    t.string "x10k_competitor__c", limit: 5
    t.string "non_eco__c", limit: 5
    t.index ["id"], name: "uecosystem_detail__c", unique: true
  end

  create_table "encumbrance_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "ent_advanced_relationship_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["name"], name: "ent_advanced_relationship_types_name_unique_idx", unique: true
  end

  create_table "ent_advanced_relationships", id: :serial, force: :cascade do |t|
    t.integer "ent_id", null: false
    t.integer "related_ent_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "ent_advanced_relationship_type_id", null: false
    t.text "description"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.string "updated_by", limit: 255, null: false
    t.string "created_by", limit: 255, null: false
    t.text "title"
    t.index ["ent_advanced_relationship_type_id"], name: "idx_ent_advanced_relationships_ent_advanced_relationship_type_i"
    t.index ["ent_id"], name: "idx_ent_advanced_relationships_ent_id"
    t.index ["related_ent_id"], name: "idx_ent_advanced_relationships_related_ent_id"
  end

  create_table "ent_advanced_relationships_temporal", id: :serial, force: :cascade do |t|
    t.integer "ent_id", null: false
    t.integer "related_ent_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "ent_advanced_relationship_type_id", null: false
    t.text "description"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.string "updated_by", limit: 255, null: false
    t.string "created_by", limit: 255, null: false
    t.text "title"
    t.index ["ent_advanced_relationship_type_id"], name: "ent_advanced_relationships_temporal_ent_advanced_relationship_t"
    t.index ["ent_id"], name: "idx_ent_advanced_relationships_temporal_ent_id"
    t.index ["related_ent_id"], name: "idx_ent_advanced_relationships_temporal_related_ent_id"
  end

  create_table "ent_relationship_types", id: :serial, force: :cascade, comment: "Types to describe ent_relationships (Parent, Attorney at, etc.)" do |t|
    t.string "name", limit: 100, null: false, comment: "Type of relationship between entities. (Parent, Attorney at, Judge for, etc.)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "ent_relationship_types_name_unique_idx", unique: true
  end

  create_table "ent_relationships", id: :serial, force: :cascade do |t|
    t.integer "ent_id", null: false, comment: "Entity ID for one part of the relationship (key to link to ents)"
    t.integer "related_ent_id", null: false, comment: "Entity ID for other part of the relationship (key to link to ents)"
    t.integer "ent_relationship_type_id", null: false, comment: "Relationship type ID (key to link to ent_relationship_types)"
    t.text "description", null: false, comment: "Descriptive text about this relationship. Free text."
    t.date "start_date", comment: "Date the relationship started"
    t.date "end_date", comment: "Date the relationship ended"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.string "created_by"
    t.string "updated_by"
    t.index ["ent_id", "related_ent_id", "ent_relationship_type_id"], name: "ent_relationships_ent_id_related_ent_id_ent_relationship_ty_idx", unique: true
    t.index ["ent_id"], name: "ent_relationships_fkey_ent_id"
    t.index ["ent_relationship_type_id"], name: "ent_relationships_fkey_ent_relationship_type_id"
    t.index ["related_ent_id"], name: "ent_relationships_fkey_related_ent_id"
  end

  create_table "ent_relationships_temporal", id: :serial, force: :cascade do |t|
    t.integer "ent_id", null: false
    t.integer "related_ent_id", null: false
    t.integer "ent_relationship_type_id", null: false
    t.text "description", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
  end

  create_table "ent_subtypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "description"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["name"], name: "ent_subtypes_name_unique_idx", unique: true
  end

  create_table "ent_subtypes_map", id: :serial, force: :cascade do |t|
    t.integer "ent_id", null: false
    t.integer "ent_subtype_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.string "updated_by", limit: 255, null: false
    t.string "created_by", limit: 255, null: false
    t.index ["ent_id"], name: "idx_ent_subtypes_map_ent_id"
  end

  create_table "ent_types", id: :serial, force: :cascade, comment: "List of types for entities" do |t|
    t.string "name", limit: 255, null: false, comment: "Entity types (Company, Person, Government, etc.)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "ent_types_name_unique_idx", unique: true
  end

  create_table "entity_contacts", id: :serial, force: :cascade, comment: "Contact information for person or corporation in entity table (docketx: contactdetails & address)" do |t|
    t.integer "ent_id", null: false, comment: "Entity ID (key to connect to ents)"
    t.string "line1", limit: 255, comment: "Street address line 1"
    t.string "line2", limit: 255, comment: "Street address line 2"
    t.string "line3", limit: 255, comment: "Street address line 3"
    t.string "city", limit: 255, comment: "City for mailing address"
    t.string "state_or_province", limit: 255, comment: "State or Province for street address. Two character abbreviation."
    t.string "postal_code", limit: 255, comment: "Zip code or postal code for mailing address. US codes are 5 digit zip or 10 digit zip+4."
    t.string "country", limit: 255, comment: "Country for mailing address"
    t.string "url", limit: 255, comment: "Web address (URL) for a company in ents. This is not an email address."
    t.string "phone", limit: 255, comment: "Phone number. Format for most US numbers is (555) 555-5555, but not all are in that form."
    t.string "fax", limit: 255, comment: "Fax number. Format for most US numbers is (555) 555-5555, but not all are in that form."
    t.string "cell", limit: 255, comment: "Cell phone number. Format for most US numbers is (555) 555-5555, but not all are in that form."
    t.string "email", limit: 255, comment: "Email address."
    t.text "notes", comment: "Notes for the entity. Free text."
    t.float "lat", comment: "Latitude of geocoded address."
    t.float "lon", comment: "Longitude of gencoded address."
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "last_known_address", default: false
    t.index ["email"], name: "entity_contacts_email_idx"
    t.index ["ent_id"], name: "entity_contacts_ent_id_idx"
    t.index ["fax"], name: "entity_contacts_fax_idx"
    t.index ["line1", "line2", "line3", "city", "state_or_province", "postal_code", "country"], name: "entity_contacts_full_address_idx"
    t.index ["phone"], name: "entity_contacts_phone_idx"
  end

  create_table "ents", id: :serial, comment: "Artificial ID", force: :cascade do |t|
    t.integer "ent_type_id", null: false, comment: "Type of entity (key to link to ent_types)"
    t.string "name", null: false, comment: "Entity name"
    t.string "core_name", limit: 255, null: false, comment: "Name converted automatically to core form (remove Co, Inc, LLC, etc. and proper cased), for use in name disambiguation."
    t.string "fingerprint", limit: 255, null: false, comment: "Name converted automatically to fingerprint (only alpha/numeric characters, lower cased and sorted), for use in name disambiguation."
    t.string "lower_stripped", limit: 255, null: false, comment: "Entity name lower cased and punctuation stripped"
    t.string "salesforce_id", limit: 18, comment: "Salesforce ID. This connects the entity to its Salesforce object. (ID of the form 0014000000xxxxx)"
    t.date "deactivation_date", comment: "Date the entity is no longer active."
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.string "created_by", limit: 255
    t.string "updated_by", limit: 255
    t.string "rpx_account_id", limit: 30, comment: "Holds the RPX account id out of SalesForce. RID also matches account RID used on the client Portal."
    t.integer "ultimate_parent_id", comment: "Calculated field, updated automatically anytime ent_relationships is updated."
    t.integer "rollup_parent_id", comment: "Automatically generated until manually changed to be different than ultimate_parent_id, then must be changed manually."
    t.boolean "not_for_portal", default: false
    t.index "core_name gist_trgm_ops", name: "ents__core_name_trgm_idx", using: :gist
    t.index "fingerprint gist_trgm_ops", name: "ents__fingerprint_trgm_idx", using: :gist
    t.index "name gist_trgm_ops", name: "ents__name_trgm_idx", using: :gist
    t.index ["created_at"], name: "ents__created_at_idx"
    t.index ["ent_type_id"], name: "ents_fkey_ent_type_id"
    t.index ["name"], name: "ents__name_unique_idx", unique: true
    t.index ["salesforce_id"], name: "ents_salesforce_id_idx"
    t.index ["ultimate_parent_id"], name: "ents__ultimate_parent_id_idx"
    t.index ["updated_at"], name: "ents__updated_at_idx"
  end

  create_table "ents_market_sector_types", id: :serial, force: :cascade, comment: "Market sector type that applys to an entity. Entities may have multiple market sectors." do |t|
    t.integer "ent_id", null: false, comment: "Entity ID (key connects to ents)"
    t.integer "market_sector_type_id", null: false, comment: "Market sector type ID (key connects to market_sector_types)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.index ["ent_id", "market_sector_type_id"], name: "ents_market_sector_types__ent_id_market_sector_type_id_uniq_idx", unique: true
    t.index ["ent_id"], name: "ents_market_sector_types_fkey_ent_id"
  end

  create_table "estimated_expenditure__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 80
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "claim__c", limit: 18
    t.decimal "amount__c", precision: 22, scale: 6
    t.string "cost_heading__c", limit: 255
    t.datetime "estimation_date__c"
    t.string "is_lae__c", limit: 5
    t.string "notes__c", limit: 255
    t.index ["id"], name: "uestimated_expenditure__c", unique: true
  end

  create_table "exercised_batch_options", id: :serial, force: :cascade do |t|
    t.datetime "exercised_date"
    t.string "entity_sf_account_id", limit: 255
    t.float "option_price"
    t.integer "option_id"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["entity_sf_account_id"], name: "exercised_batch_options_account_id_idx"
    t.index ["option_id"], name: "exercised_batch_options_option_id_idx"
  end

  create_table "feedback__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "account__c", limit: 18
    t.string "acquisition_opportunity__c", limit: 18
    t.string "assigned_to__c", limit: 18
    t.datetime "completed_date__c"
    t.string "contact__c", limit: 18
    t.string "depth_of_feedback__c", limit: 255
    t.string "feedback_burden__c", limit: 255
    t.string "feedback_received_comments__c", limit: 765
    t.string "feedback_requested_comments__c", limit: 765
    t.string "opportunity__c", limit: 18
    t.string "status__c", limit: 255
    t.string "updated_barker_model__c", limit: 5
    t.text "assigned_to_is_current_user__c"
    t.string "account_primary_patent_analyst", limit: 240
    t.index ["id"], name: "ufeedback__c", unique: true
  end

  create_table "file_types", id: :serial, force: :cascade do |t|
    t.string "description", limit: 50
    t.boolean "is_default"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["description"], name: "file_types_description_key", unique: true
  end

  create_table "file_types", id: :serial, force: :cascade do |t|
    t.string "description", limit: 50
    t.boolean "is_default"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["description"], name: "file_types_description_key", unique: true
  end

  create_table "financial_detail__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.string "recordtypeid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "application__c", limit: 18
    t.string "customer__c", limit: 765
    t.string "detail_type__c", limit: 255
    t.string "fiscal_year_ended__c", limit: 255
    t.string "product_name__c", limit: 240
    t.decimal "x2011__c", precision: 18
    t.decimal "x2012__c", precision: 18
    t.decimal "x2013__c", precision: 18
    t.decimal "x2014__c", precision: 18
    t.decimal "funding_amount__c", precision: 24, scale: 6
    t.datetime "funding_date__c"
    t.string "series_round__c", limit: 765
    t.string "x2011_text__c", limit: 765
    t.string "x2012_text__c", limit: 765
    t.string "x2013_text__c", limit: 765
    t.string "x2014_text__c", limit: 765
    t.string "lead_investors__c", limit: 765
    t.string "cash__c", limit: 765
    t.string "customer_name__c", limit: 765
    t.string "customer_value__c", limit: 765
    t.string "e_commerce_revenue__c", limit: 765
    t.string "gross_revenue__c", limit: 765
    t.string "headcount__c", limit: 765
    t.string "operating_income__c", limit: 765
    t.string "other_revenue__c", limit: 765
    t.decimal "position__c", precision: 18
    t.string "product_value__c", limit: 765
    t.string "us_revenue__c", limit: 765
    t.string "year__c", limit: 765
    t.index ["id"], name: "ufinancial_detail__c", unique: true
  end

  create_table "flr_campaign__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "flr_campaign_master__c", limit: 18
    t.string "accused_products__c", limit: 765
    t.string "adjustment__c", limit: 5
    t.text "broker_names__c"
    t.text "campaignid__c"
    t.decimal "campaign_id__c", precision: 18
    t.string "campaign_name__c", limit: 765
    t.string "court__c", limit: 150
    t.string "exists__c", limit: 5
    t.datetime "first_filed_date__c"
    t.datetime "latest_filed_date__c"
    t.text "lawfirm_names__c"
    t.string "ncs__c", limit: 255
    t.decimal "open_cases__c", precision: 18
    t.string "primary_market_sector__c", limit: 255
    t.string "probability_of_assertion__c", limit: 765
    t.string "rpx_deal_involvement__c", limit: 255
    t.string "intentionally_excluded__c", limit: 5
    t.decimal "max_probability_of_assertion", precision: 5, scale: 2
    t.string "min_probability_of_assertion", limit: 255
    t.string "notes__c", limit: 765
    t.text "accused_product_service_tags"
    t.string "acquisition__c", limit: 18
    t.decimal "codefs_in_this_eco__c", precision: 18
    t.text "eco_defendants__c"
    t.string "is_a_ptab_challenge__c", limit: 255
    t.string "pct_of_codefs__c", limit: 765
    t.string "ptab_case_types__c", limit: 765
    t.decimal "total_codefs__c", precision: 18
    t.text "patent_titles__c"
    t.string "risk_causing__c", limit: 5
    t.string "relevant_defendants__c", limit: 255
    t.string "non_eco_prior_codefs_count__c", limit: 18
    t.index ["id"], name: "uflr_campaign__c", unique: true
  end

  create_table "flr_campaign_master__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "account__c", limit: 18
    t.string "status__c", limit: 255
    t.decimal "version__c", precision: 18
    t.index ["id"], name: "uflr_campaign_master__c", unique: true
  end

  create_table "foreign_application_priority_docs", id: :serial, force: :cascade do |t|
    t.integer "pat_id", null: false
    t.string "document_id", limit: 255, null: false
    t.string "country", limit: 255, null: false
    t.date "document_date", null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["pat_id", "document_id"], name: "foreign_application_priority_docs__pat_id_document_id_uniq_idx", unique: true
  end

  create_table "indemnification_request__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "application__c", limit: 18
    t.decimal "amount_of_indemnification_paid", precision: 24, scale: 6
    t.string "assertion_status__c", limit: 255
    t.string "did_you_get_any_indemnificatio", limit: 255
    t.decimal "estimated_to_others__c", precision: 22, scale: 6
    t.decimal "estimated_to_you__c", precision: 22, scale: 6
    t.datetime "first_contact_date__c"
    t.datetime "last_contact_date__c"
    t.decimal "legal_cost__c", precision: 24, scale: 6
    t.decimal "license_resolution__c", precision: 24, scale: 6
    t.string "matter_name__c", limit: 765
    t.string "parent_plaintiff__c", limit: 240
    t.string "patents__c", limit: 765
    t.string "requesting_party__c", limit: 765
    t.datetime "resolved_date__c"
    t.string "seeking_indemnification__c", limit: 255
    t.string "settlement_details__c", limit: 765
    t.string "supplier_seeking_indemnificati", limit: 240
    t.string "technology_asserted__c", limit: 240
    t.decimal "amount_of_indemn_paid_verified", precision: 24, scale: 6
    t.string "application_verified__c", limit: 240
    t.string "assertion_status_verified__c", limit: 255
    t.string "received_indemn_requests_verif", limit: 255
    t.decimal "estimated_to_others_verified", precision: 22, scale: 6
    t.decimal "estimated_to_you_verified__c", precision: 22, scale: 6
    t.datetime "first_contact_date_verified__c"
    t.datetime "last_contact_date_verified__c"
    t.decimal "legal_cost_verified__c", precision: 24, scale: 6
    t.decimal "license_resolution_verified__c", precision: 24, scale: 6
    t.string "matter_name_verified__c", limit: 765
    t.string "parent_plaintiff_verified__c", limit: 240
    t.string "patents_verified__c", limit: 765
    t.string "requesting_party_verified__c", limit: 765
    t.datetime "resolved_date_verified__c"
    t.string "seeking_indemnification_verifi", limit: 255
    t.string "settlement_details_verified__c", limit: 765
    t.string "supplier_seeking_indemn_from_v", limit: 240
    t.string "technology_asserted_verified", limit: 240
    t.string "accused_products__c", limit: 765
    t.string "court__c", limit: 150
    t.string "how_resolved_stage_reached__c", limit: 765
    t.string "include_in_frequency__c", limit: 5
    t.string "include_in_severity__c", limit: 5
    t.string "ncs__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "rpx_deal_involvement__c", limit: 255
    t.string "notes__c", limit: 255
    t.boolean "competitor__c"
    t.string "type__c", limit: 255
    t.string "accepted_denied__c", limit: 255
    t.index ["id"], name: "uindemnification_request__c", unique: true
  end

  create_table "inpadoc_ipr_events", id: :integer, default: nil, force: :cascade do |t|
    t.string "country_code", limit: 2
    t.string "doc_format", limit: 1
    t.string "doc_number", limit: 20
    t.string "doc_kind_code", limit: 2
    t.string "ipr_type", limit: 2
    t.date "legal_event_date"
    t.string "legal_event_code", limit: 4
    t.string "status", limit: 1
    t.date "pub_date"
    t.string "pub_number", limit: 17
    t.date "last_date_exchanged"
    t.date "event_created_date"
    t.integer "app_doc_id"
    t.string "national_office_code", limit: 2
    t.string "national_event_code", limit: 4
    t.string "national_doc_number", limit: 20
    t.string "national_country_code", limit: 2
    t.date "national_pub_date"
    t.string "national_doc_kind_code", limit: 2
    t.string "states", limit: 300
    t.string "ext_state", limit: 20
    t.string "owner_name", limit: 200
    t.text "free_format_text"
    t.string "spc_number", limit: 30
    t.date "spc_filing_date"
    t.date "exp_date"
    t.string "pub_lang", limit: 2
    t.string "inventor_name", limit: 200
    t.text "ipc"
    t.string "representative_name", limit: 200
    t.date "payment_date"
    t.string "opponent_name", limit: 200
    t.integer "year_of_payment"
    t.string "requester_name", limit: 200
    t.date "spc_ext_date"
    t.string "ext_states", limit: 100
    t.date "effective_date"
    t.date "withdrawal_date"
  end

  create_table "inpadoc_legal_status_codes", id: :integer, default: nil, force: :cascade do |t|
    t.string "country_code", limit: 2
    t.string "legal_status_code", limit: 4
    t.string "impact", limit: 1
    t.text "description"
  end

  create_table "insurance_client_acquisitions", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 80
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "client__c", limit: 18
    t.string "acquisition__c", limit: 18
    t.text "stage__c"
    t.datetime "last_significant_acq_update__c"
    t.text "type__c"
    t.datetime "acq_close_date__c"
    t.datetime "purchase_date__c"
    t.text "patent_ncs__c"
    t.text "ncs__c"
    t.index ["id"], name: "uinsurance_client_acquisitions", unique: true
  end

  create_table "intake_pat_families", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
  end

  create_table "intake_pat_family_pats", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.integer "pat_family_id"
    t.string "patnum", limit: 64
    t.string "stripped_patnum", limit: 32
    t.string "app_num_intl", limit: 64
    t.string "country_code", limit: 16
    t.date "app_date"
    t.string "app_country", limit: 16
    t.integer "iteration"
    t.integer "iter_type"
    t.datetime "created_at"
    t.index ["pat_id"], name: "idx_intake_pat_family_pats_id", unique: true
  end

  create_table "invention_owners", id: :serial, force: :cascade do |t|
    t.integer "invention_id"
    t.string "owner"
    t.integer "alias_ids", array: true
    t.date "ownership_start"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by"
    t.string "updated_by"
    t.index "alias_ids gin__int_ops", name: "invention_owners_alias_ids_idx", using: :gin
    t.index ["invention_id", "owner"], name: "invention_owner_uniq_idx", unique: true
    t.index ["invention_id"], name: "invention_owners_invention_id_idx"
  end

  create_table "ipc_classes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 3, null: false
    t.integer "ipc_section_id"
    t.string "description", limit: 3000
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.index ["code"], name: "uidx_ipc_classes_code", unique: true
  end

  create_table "ipc_classes_hist", id: :serial, force: :cascade do |t|
    t.integer "ipc_class_id"
    t.string "code", limit: 3, null: false
    t.integer "ipc_section_id"
    t.string "description", limit: 3000
    t.string "transaction_type", limit: 10, null: false
    t.string "xml_edition", limit: 50
    t.integer "job_id"
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
    t.tsrange "effective_date"
  end

  create_table "ipc_groups", id: :serial, force: :cascade do |t|
    t.string "code", limit: 8, null: false
    t.string "orig_code", limit: 14, null: false
    t.integer "ipc_section_id"
    t.integer "ipc_class_id"
    t.integer "ipc_subclass_id"
    t.string "description", limit: 5000
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.index ["code"], name: "uidx_ipc_groups_code", unique: true
  end

  create_table "ipc_groups_hist", id: :serial, force: :cascade do |t|
    t.integer "ipc_group_id"
    t.string "code", limit: 8, null: false
    t.string "orig_code", limit: 14, null: false
    t.integer "ipc_section_id"
    t.integer "ipc_class_id"
    t.integer "ipc_subclass_id"
    t.string "description", limit: 5000
    t.string "transaction_type", limit: 10, null: false
    t.string "xml_edition", limit: 50
    t.integer "job_id"
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
    t.tsrange "effective_date"
  end

  create_table "ipc_sections", id: :serial, force: :cascade do |t|
    t.string "code", limit: 1, null: false
    t.string "description", limit: 1000
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.index ["code"], name: "uidx_ipc_sections_code", unique: true
  end

  create_table "ipc_sections_hist", id: :serial, force: :cascade do |t|
    t.integer "ipc_section_id"
    t.string "code", limit: 1, null: false
    t.string "description", limit: 1000
    t.string "transaction_type", limit: 10, null: false
    t.string "xml_edition", limit: 50
    t.integer "job_id"
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
    t.tsrange "effective_date"
  end

  create_table "ipc_subclasses", id: :serial, force: :cascade do |t|
    t.string "code", limit: 4, null: false
    t.integer "ipc_class_id"
    t.integer "ipc_section_id"
    t.string "description", limit: 5000
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.index ["code"], name: "uidx_ipc_subclasses_code", unique: true
  end

  create_table "ipc_subclasses_hist", id: :serial, force: :cascade do |t|
    t.integer "ipc_subclass_id"
    t.string "code", limit: 4, null: false
    t.integer "ipc_class_id"
    t.integer "ipc_section_id"
    t.string "description", limit: 5000
    t.string "transaction_type", limit: 10, null: false
    t.string "xml_edition", limit: 50
    t.integer "job_id"
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
    t.tsrange "effective_date"
  end

  create_table "ipc_subgroups", id: :serial, force: :cascade do |t|
    t.string "code", limit: 14, null: false
    t.string "code_docdb", limit: 14, null: false
    t.string "orig_code", limit: 14, null: false
    t.integer "ipc_section_id"
    t.integer "ipc_class_id"
    t.integer "ipc_subclass_id"
    t.integer "ipc_group_id"
    t.string "ipc_edition", limit: 100
    t.integer "parent_subgroup_id"
    t.string "description", limit: 5000
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.index ["code"], name: "uidx_ipc_subgroups_code", unique: true
    t.index ["created_at"], name: "ipc_subgroups__created_at_idx"
    t.index ["updated_at"], name: "ipc_subgroups__updated_at_idx"
  end

  create_table "ipc_subgroups_hist", id: :serial, force: :cascade do |t|
    t.integer "ipc_subgroup_id"
    t.string "code", limit: 14, null: false
    t.string "code_docdb", limit: 14, null: false
    t.string "orig_code", limit: 14, null: false
    t.integer "ipc_section_id"
    t.integer "ipc_class_id"
    t.integer "ipc_subclass_id"
    t.integer "ipc_group_id"
    t.string "ipc_edition", limit: 100
    t.integer "parent_subgroup_id"
    t.string "description", limit: 5000
    t.string "transaction_type", limit: 10, null: false
    t.string "xml_edition", limit: 50
    t.integer "job_id"
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
    t.tsrange "effective_date"
  end

  create_table "ipc_transfer", id: :serial, force: :cascade do |t|
    t.string "from_code", limit: 14, null: false
    t.string "to_code", limit: 14, null: false
    t.string "kind_code", limit: 1
    t.string "compilation_file_name", limit: 100, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
  end

  create_table "judge_assignment_types", id: :serial, comment: "Assignment type ID (key connects to lit_judges_map)", force: :cascade, comment: "Assignments for judges. (docketx: caseassignment)" do |t|
    t.string "name", limit: 255, null: false, comment: "Name/description of assignment (ASSIGNED, REFFERED) (docketx:  caseassignment.assignmenttype)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "judge_assignment_types_name_unique_idx", unique: true
  end

  create_table "kudelski_assets_dump", id: false, force: :cascade do |t|
    t.integer "id"
    t.text "title"
    t.text "country"
    t.text "country_desc"
    t.text "status"
    t.text "filed_date_text"
    t.date "filed_date"
    t.text "application_number_raw"
    t.text "grant_date_text"
    t.date "grant_date"
    t.text "patent_number_raw"
    t.text "asset_source"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
  end

  create_table "kudelski_assets_dump_round2", id: false, force: :cascade do |t|
    t.integer "id"
    t.text "application_number_raw"
    t.text "patent_number_raw"
    t.text "title"
    t.text "country_desc"
    t.text "country"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
  end

  create_table "lawfirm_aliases_to_map_tmp", id: false, force: :cascade do |t|
    t.bigint "lawfirm_alias_id"
    t.string "lawfirm_core_name"
    t.bigint "lawfirm_alias_ids_to_map", array: true
    t.integer "lawfirm_ent_id"
    t.integer "lawfirm_ent_ids", array: true
    t.bigint "lawfirm_ent_id_cnt"
    t.bigint "cluster_lawfirm_alias_ids", array: true
    t.bigint "alias_id_to_create_ent_id"
    t.text "proposed_ent_name"
    t.index ["cluster_lawfirm_alias_ids"], name: "lawfirm_aliases_to_map_tmp_cluster_lawfirm_alias_ids_idx", using: :gin
  end

  create_table "lawfirm_core_names_tmp_ds_5676", id: false, force: :cascade do |t|
    t.bigint "lawfirm_alias_id"
    t.integer "lawfirm_ent_id"
    t.string "lawfirm_alias_name", limit: 512
    t.string "lawfirm_core_name"
    t.text "lawfirm_sources", array: true
  end

  create_table "lawfirm_ent_core_names_ds_5676", id: false, force: :cascade do |t|
    t.integer "lawfirm_ent_id"
    t.string "ent_lawfirm_core_name"
    t.text "lawfirm_sources", array: true
  end

  create_table "lawfirm_maps", id: false, force: :cascade do |t|
    t.bigint "lawfirm_alias_id"
    t.string "lawfirm_core_name"
    t.bigint "sim_lawfirm_alias_id"
    t.string "sim_lawfirm_core_name"
    t.float "sim_score"
    t.index ["sim_score"], name: "lawfirm_maps_sim_score_idx"
  end

  create_table "lead", id: false, force: :cascade do |t|
    t.serial "etl_id", null: false
    t.boolean "delete_flag", default: false
    t.text "id"
    t.boolean "isconverted"
    t.boolean "isdeleted"
    t.boolean "donotcall"
    t.boolean "hasoptedoutofemail"
    t.boolean "hasoptedoutoffax"
    t.boolean "objectors__c"
    t.boolean "rpx_pricing_justified__c"
    t.boolean "specific_cases_mentioned__c"
    t.boolean "understands_rpx_model__c"
    t.boolean "isunreadbyowner"
    t.boolean "upstream_awareness__c"
    t.datetime "converteddate"
    t.datetime "createddate"
    t.datetime "emailbounceddate"
    t.datetime "lastactivitydate"
    t.datetime "lastmodifieddate"
    t.datetime "lastreferenceddate"
    t.datetime "lasttransferdate"
    t.datetime "lastvieweddate"
    t.datetime "pi__conversion_date__c"
    t.datetime "pi__created_date__c"
    t.datetime "pi__first_activity__c"
    t.datetime "pi__last_activity__c"
    t.datetime "systemmodstamp"
    t.float "annualrevenue"
    t.float "numberofemployees"
    t.float "entity_id__c"
    t.float "latitude"
    t.float "longitude"
    t.float "pi__score__c"
    t.text "bid_dealine__c"
    t.text "brief_description__c"
    t.text "broker_name__c"
    t.text "city"
    t.text "company"
    t.text "convertedaccountid"
    t.text "convertedcontactid"
    t.text "convertedopportunityid"
    t.text "country"
    t.text "createdbyid"
    t.text "jigsaw"
    t.text "description"
    t.text "d_u_n_s__c"
    t.text "email"
    t.text "emailbouncedreason"
    t.text "fax"
    t.text "firstname"
    t.text "namex"
    t.text "pi__utm_campaign__c"
    t.text "pi__utm_content__c"
    t.text "pi__utm_medium__c"
    t.text "pi__utm_source__c"
    t.text "pi__utm_term__c"
    t.text "industry"
    t.text "interested_in__c"
    t.text "jigsawcontactid"
    t.text "lastmodifiedbyid"
    t.text "lastname"
    t.text "currencyisocode"
    t.text "leadsource"
    t.text "lid__linkedin_company_id__c"
    t.text "lid__linkedin_member_token__c"
    t.text "masterrecordid"
    t.text "mobilephone"
    t.text "objections__c"
    t.text "opportunity_type__c"
    t.text "ownerid"
    t.text "owner_of_patents__c"
    t.text "pi__campaign__c"
    t.text "pi__comments__c"
    t.text "pi__conversion_object_name__c"
    t.text "pi__conversion_object_type__c"
    t.text "pi__first_touch_url__c"
    t.text "pi__first_search_term__c"
    t.text "pi__first_search_type__c"
    t.text "pi__grade__c"
    t.text "pi__notes__c"
    t.text "pi__url__c"
    t.text "patent_application_numbers__c"
    t.text "phone"
    t.text "photourl"
    t.text "potential_litigation_threats__c"
    t.text "rating"
    t.text "salutation"
    t.text "specific_cases__c"
    t.text "state"
    t.text "status"
    t.text "street"
    t.text "title"
    t.text "valuation_expectation__c"
    t.text "website"
    t.text "postalcode"
    t.index ["id"], name: "sf_lead_uk", unique: true
  end

  create_table "lit_annotations", id: :serial, force: :cascade, comment: "Human created annotations for litigations (data01: rpx_casedata)" do |t|
    t.integer "lit_id", default: -> { "nextval('lit_annotations_id_seq'::regclass)" }, null: false, comment: "Litigation ID (key connects to lits)"
    t.string "rpx_lit_id", limit: 16, comment: "RPX Lit ID (RLD-000000) - alternate unique identifier. (data01: rpx_casedata.rpxlitid)"
    t.integer "lit_type_id", comment: "Lit type ID (key connects to lit_types) (data01: rpx_casedata.case_type)"
    t.boolean "is_npe_suit", default: false, null: false, comment: "0==false, 1==true (data01: rpx_casedata.npesuitflag)"
    t.boolean "is_dj", null: false, comment: "Is the case requesting declaratory judgment? (data01: rpx_casedata.isdj)"
    t.integer "market_sector_type_id", comment: "Market sector code (1-18; key connects to market_sector_types) (data01: rpx_casedata.marketsector)"
    t.integer "lit_classification_type_id", comment: "Lit classification type ID (key connects to lit_classification_types)\n(data01: rpx_casedata.case_classification)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", default: -> { "(now())::timestamp without time zone" }, null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_abandon", default: false, null: false, comment: "True if case was abandoned by the court.  Some cases are abandoned (not closed, but never updated) at the ECF level. (data01: rpx_casedata.transferflag = 'A')"
    t.text "ad_hoc_1", comment: "place for data services people to put their own special stuff"
    t.text "ad_hoc_2", comment: "place for data services people to put their own special stuff"
    t.text "ad_hoc_3", comment: "place for data services people to put their own special stuff"
    t.text "ad_hoc_4", comment: "place for data services people to put their own special stuff"
    t.text "ad_hoc_5", comment: "place for data services people to put their own special stuff"
    t.integer "lit_curated_cause_type_id", comment: "Litigation cause, human currated"
    t.boolean "is_ncl_suit", default: false, null: false
    t.boolean "is_dcl_corrected"
    t.boolean "display_on_portal"
    t.boolean "portal_display_override"
    t.integer "latest_document_id"
    t.index ["lit_id"], name: "lit_annotations__lit_id_uniq_idx", unique: true
    t.index ["lit_type_id"], name: "lit_annotations_fkey_lit_type_id"
    t.index ["market_sector_type_id"], name: "lit_annotations_fkey_market_sector_type_id"
  end

  create_table "lit_annotations_deleted", id: false, force: :cascade do |t|
    t.integer "lit_id"
    t.string "rpx_lit_id", limit: 16
    t.integer "lit_type_id"
    t.boolean "is_npe_suit"
    t.boolean "is_dj"
    t.integer "market_sector_type_id"
    t.integer "lit_classification_type_id"
    t.integer "lit_stage_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.boolean "is_abandon"
    t.text "ad_hoc_1"
    t.text "ad_hoc_2"
    t.text "ad_hoc_3"
    t.text "ad_hoc_4"
    t.text "ad_hoc_5"
    t.integer "lit_curated_cause_type_id"
    t.integer "id"
    t.boolean "is_ncl_suit"
    t.boolean "is_dcl_corrected"
    t.boolean "display_on_portal"
    t.boolean "portal_display_override"
  end

  create_table "lit_case_aliases", id: :serial, force: :cascade do |t|
    t.integer "lit_id"
    t.integer "new_docket_info_id"
    t.integer "old_docket_info_id"
    t.string "new_docket_number", limit: 32
    t.string "old_docket_number", limit: 32
    t.string "new_case_key", limit: 32
    t.string "old_case_key", limit: 32
  end

  create_table "lit_case_stages", id: :serial, force: :cascade, comment: "This table contains the history of case stages for a litigation. The data in this table is generated automatically by PriorSmart code." do |t|
    t.integer "lit_id", null: false
    t.integer "lit_stage_id", null: false, comment: "This id corresponds to the lit_stages table. Use lit_stage_id to join to lit_stages to retrieve the name of the stage."
    t.boolean "is_current", null: false, comment: "Designates if the given stage is the current stage for the associated litigation. If litigation is closed, this is the stage in which the litigation closed. Comment updated at: 2012-11-06"
    t.text "comment", comment: "Basic explanation why the given case was selected. For debugging purposes only. Comment updated at: 2012-11-06"
    t.date "start_date", null: false, comment: "Date on which the automated logic determined the case stage to start.  Comment updated at: 2012-11-06"
    t.integer "start_entry_index", null: false
    t.date "end_date", comment: "Date on which the automated logic determined the case stage ended. If the case is still open and ongoing, the end_date is NULL for the current stage. If the case is closed, the end date of the last stage is the closed date of the litigation.  Comment updated at: 2012-11-06"
    t.integer "end_entry_index"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["lit_id", "lit_stage_id"], name: "idx_lit_case_stages_lit_stage", unique: true
  end

  create_table "lit_case_stages_deleted", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "lit_id"
    t.integer "lit_stage_id"
    t.boolean "is_current"
    t.text "comment"
    t.date "start_date"
    t.integer "start_entry_index"
    t.date "end_date"
    t.integer "end_entry_index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lit_cause_types", id: :serial, comment: "Lit Cause ID (key connects to lits)", force: :cascade, comment: "Cause for the litigation (docketx: districtdocket.cause)" do |t|
    t.string "name", limit: 255, null: false, comment: "PACER code and name of case type (e.g. \"35:271 Patent Infringement\")\n(docketx: districtdocket.cause)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "lit_cause_types_name_unique_idx", unique: true
  end

  create_table "lit_classification_types", id: :serial, force: :cascade, comment: "(data01: rpx_casedata.case_classification)" do |t|
    t.string "name", limit: 255, null: false, comment: "RPX Lit Classification (Nuisance/Credible/Sophisticated)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "lit_classification_types_name_unique_idx", unique: true
  end

  create_table "lit_courts", id: :serial, force: :cascade, comment: "Litigation courts (connnects litigations to the aliases for the courts)" do |t|
    t.integer "lit_id", null: false, comment: "Litigation ID (key connects to lits)"
    t.integer "alias_id", null: false, comment: "Alias ID (key connects to aliases)"
    t.date "start_date", comment: "Start date of venue tenure"
    t.date "end_date", comment: "End date of venue tenure"
    t.boolean "is_verified", default: false, null: false, comment: "has the alias->court mapping been approved by a human?"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.string "verified_by", limit: 255
    t.index ["alias_id"], name: "lit_courts_fkey_alias_id"
    t.index ["lit_id", "alias_id"], name: "lit_courts_skey", unique: true
    t.index ["lit_id"], name: "lit_courts_fkey_lit_id"
  end

  create_table "lit_courts_deleted", id: false, force: :cascade do |t|
    t.integer "lit_id"
    t.integer "alias_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_verified"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "id"
    t.string "verified_by", limit: 255
  end

  create_table "lit_curated_cause_types", id: :serial, comment: "Artificial ID", force: :cascade, comment: "\"normalized\" causes for litigations" do |t|
    t.string "name", limit: 255, null: false, comment: "Cause types (Declaratory Judgment, Willful Patent Infringement, Ownership Dispute, etc.)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "lit_curated_cause_types_name_unique_idx", unique: true
  end

  create_table "lit_document_orphans", id: :serial, force: :cascade do |t|
    t.integer "lit_document_id", null: false
    t.integer "lit_id"
    t.string "case_key", limit: 32
    t.text "original_docket_text"
    t.integer "entry_number"
    t.date "entry_date_filed"
    t.datetime "updated_at", comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", comment: "Date and time the record was created. Controlled automatically by the database."
    t.index ["lit_document_id"], name: "lit_document_orphans__lit_document_id_uniq_key", unique: true
  end

  create_table "lit_document_statuses", id: :serial, force: :cascade do |t|
    t.string "description", limit: 50
    t.text "note"
    t.boolean "is_default"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["description"], name: "lit_document_statuses_description_key", unique: true
  end

  create_table "lit_document_types", id: :serial, force: :cascade do |t|
    t.string "description", limit: 50
    t.boolean "is_default", default: false
    t.datetime "updated_at"
    t.datetime "created_at"
    t.boolean "is_archived"
    t.index ["description"], name: "lit_document_types_description_key", unique: true
  end

  create_table "lit_documents", id: :serial, comment: "Lit Document ID (key connects to docket_entry_documents_map)", force: :cascade, comment: "Electronically filed documents (from PACER)" do |t|
    t.string "docketx_id", limit: 36, comment: "DocketX document ID (docketx: document.id)"
    t.integer "doc_num", comment: "Parameter for document URL"
    t.integer "de_seq_num", comment: "Parameter for document URL"
    t.integer "dm_id", comment: "Parameter for document URL"
    t.string "url", limit: 255, null: false, comment: "Document URL (docketx: document.documenturl)"
    t.integer "lit_document_type_id", default: 0
    t.integer "file_type_id", default: 0
    t.string "rpx_file_name", limit: 255
    t.string "rpx_file_location", limit: 255
    t.integer "document_status_id", default: 1, null: false
    t.text "document_status_message"
    t.string "case_key", limit: 30
    t.datetime "updated_at", precision: 6, null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", precision: 6, null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.datetime "ocred_at", precision: 6, null: true, comment: "Date and time the document ocred. Controlled by user."
    t.integer "old_id"
    t.integer "no_of_pages"
    t.text "ocr_text"
    t.string "pdf_type", comment: "plain pdf or scanned pdf, when the pdf contains scanned images."
    t.integer "billable_pages"
    t.float "cost"
    t.boolean "needs_ocr", default: false
    t.text "ocr_exception"
    t.string "ocr_text_s3_path", limit: 255
    t.integer "ocr_priority", default: 3
    t.index "regexp_replace((rpx_file_name)::text, '.*\\/.*\\/.*\\/'::text, ''::text)", name: "idx_lit_documents_normalized_file_name"
    t.index ["created_at"], name: "lit_documents_created_at_idx"
    t.index ["updated_at"], name: "lit_documents_updated_at_idx"
    t.index ["url"], name: "lit_documents__url_uniq_idx", unique: true
  end

  create_table "lit_documents_download_semaphore", id: false, force: :cascade do |t|
    t.integer "semaphore"
  end

  create_table "lit_families", id: :serial, force: :cascade do |t|
    t.boolean "is_obsolete"
    t.integer "new_family_id", array: true
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "lit_judges_map", id: :serial, force: :cascade, comment: "Judges assigned to litigations (docketx: caseassignment)" do |t|
    t.integer "alias_id", null: false, comment: "Alias ID (key connects to aliases)"
    t.integer "lit_id", null: false, comment: "Litigation ID (key connects to lits)"
    t.integer "assignment_type_id", null: false, comment: "Assignment type ID (key connects to judge_assignment_types) (docketx: caseassignment.assignmenttype)"
    t.boolean "is_terminated", default: false, null: false, comment: "Is this judge no longer on this case? (docketx: caseassignment.isterminated)"
    t.string "assignment_role_as_filed", limit: 255, comment: "Role (honorable, magistrate, etc., as spidered) (docketx: caseassignment.assignmentrole)"
    t.date "end_date", comment: "End date of assignment tenure"
    t.date "start_date", null: false, comment: "Start date of assignment tenure"
    t.boolean "is_verified", default: false, null: false, comment: "has the alias->ent mapping been approved by a human?"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.string "verified_by", limit: 255
    t.date "missing_from_source_date"
    t.index ["alias_id", "lit_id", "assignment_type_id", "start_date", "assignment_role_as_filed"], name: "lit_judges_map_skey", unique: true
    t.index ["alias_id"], name: "lit_judges_map_fkey_alias_id"
    t.index ["lit_id"], name: "lit_judges_map_fkey_lit_id"
  end

  create_table "lit_judges_map_deleted", id: false, force: :cascade do |t|
    t.integer "alias_id"
    t.integer "lit_id"
    t.integer "assignment_type_id"
    t.boolean "is_terminated"
    t.string "assignment_role_as_filed", limit: 255
    t.date "end_date"
    t.date "start_date"
    t.boolean "is_verified"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "id"
    t.string "verified_by", limit: 255
    t.date "missing_from_source_date"
  end

  create_table "lit_parties", id: :serial, comment: "Lit parties ID (key connects to lit_parties_representations)", force: :cascade, comment: "Litigation parties (plaintiffs, defendants, ...) (docketx: representedparty and representation)" do |t|
    t.integer "alias_id", null: false, comment: "Alias ID (key connects to aliases)"
    t.integer "lit_party_type_id", null: false, comment: "Lit party type ID (key connects to lit_party_types)"
    t.integer "lit_id", null: false, comment: "Litigation ID (key connects to lits)"
    t.integer "alias_contact_id", comment: "Entity-Address ID (key connects to alias_contacts)"
    t.integer "lit_party_practice_type_id", default: 0, null: false, comment: "Lit party practice type ID (key connects to lit_party_practice_types)\nDefaults to 0 - Unknown"
    t.date "start_date", comment: "Start date of party tenure"
    t.date "end_date", comment: "End date of party tenure (docketx: representation.litigantterminatedate)"
    t.boolean "is_verified", default: false, null: false, comment: "has the lit_party -> alias->ent mapping been approved by a human?"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_removed_from_pacer", default: false
    t.string "verified_by", limit: 255
    t.string "salesforce_id", limit: 18
    t.date "missing_from_source_date"
    t.string "dj_party_normalized_type", limit: 255
    t.boolean "is_dcl_corrected"
    t.string "campaign_party_normalized_type", limit: 255
    t.index ["alias_contact_id"], name: "idx_lit_parties_contact_id"
    t.index ["alias_id"], name: "lit_parties_fkey_alias_id"
    t.index ["lit_id"], name: "lit_parties_fkey_lit_id"
    t.index ["lit_party_type_id"], name: "lit_parties_fkey_lit_party_type_id"
    t.index ["updated_at"], name: "lit_parties__updated_at_idx"
  end

  create_table "lit_parties_deleted", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "alias_id"
    t.integer "lit_party_type_id"
    t.integer "lit_id"
    t.integer "alias_contact_id"
    t.integer "lit_party_practice_type_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_verified"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.boolean "is_removed_from_pacer"
    t.string "verified_by", limit: 255
    t.string "salesforce_id", limit: 18
    t.date "missing_from_source_date"
    t.string "dj_party_normalized_type", limit: 255
    t.boolean "is_dcl_corrected"
    t.string "campaign_party_normalized_type", limit: 255
    t.index ["alias_id", "lit_party_type_id"], name: "idx_lit_parties_deleted_alias_party_type"
  end

  create_table "lit_parties_representations", id: :serial, force: :cascade, comment: "Which lawyers from which law firms represent which parties in a litagation. (docketx: representation)" do |t|
    t.integer "lit_parties_id", null: false, comment: "Lit parties ID (key connects to lit_parties)"
    t.integer "lawfirm_alias_id", null: false, comment: "Law firm ID (key connects to aliases)"
    t.integer "lawyer_alias_id", null: false, comment: "Lawyer ID (key connects to aliases)"
    t.boolean "is_lead_lawyer", default: false, comment: "Is this lawyer a lead attorney? (docketx: representation.leadattorney)"
    t.boolean "is_notify_lawyer", default: false, comment: "Is this lawyer to be notified of any changes in docket? (docketx: representation.notifyattorney)"
    t.integer "lawyer_alias_contact_id", comment: "Lawyer-Address ID (key connects to alias_contacts)"
    t.integer "lawfirm_alias_contact_id", comment: "Law Firm-Address ID (key connects to alias_contacts)"
    t.boolean "is_local_lawyer", default: false, comment: "does lawyer reside in court district?"
    t.date "start_date", comment: "Start date of representation"
    t.date "end_date", comment: "End date of representation"
    t.boolean "is_verified", default: false, null: false, comment: "has the alias->ent mapping (for lawyer and lawfirm) been approved by a human?"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.string "verified_by", limit: 255
    t.date "missing_from_source_date"
    t.boolean "is_dcl_corrected"
    t.index ["lawfirm_alias_contact_id"], name: "lit_parties_representations_fkey_lawfirm_alias_contact_id"
    t.index ["lawfirm_alias_id"], name: "lit_parties_representations_fkey_lawfirm_alias_id"
    t.index ["lawyer_alias_contact_id"], name: "lit_parties_representations_fkey_lawyer_alias_contact_id"
    t.index ["lawyer_alias_id"], name: "lit_parties_representations_fkey_lawyer_alias_id"
    t.index ["lit_parties_id", "lawyer_alias_id", "lawfirm_alias_id"], name: "lit_parties_representations_skey"
  end

  create_table "lit_parties_representations_deleted", id: false, force: :cascade do |t|
    t.integer "lit_parties_id"
    t.integer "lawfirm_alias_id"
    t.integer "lawyer_alias_id"
    t.boolean "is_lead_lawyer"
    t.boolean "is_notify_lawyer"
    t.integer "lawyer_alias_contact_id"
    t.integer "lawfirm_alias_contact_id"
    t.boolean "is_local_lawyer"
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_verified"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "id"
    t.string "verified_by", limit: 255
    t.date "missing_from_source_date"
    t.boolean "is_dcl_corrected"
    t.index ["id"], name: "idx_lit_parties_representations_deleted_id"
  end

  create_table "lit_party_normalized_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.boolean "is_default", default: false
    t.datetime "created_at", comment: "Date and time the record was created. Controlled automatically by the database."
    t.datetime "updated_at", comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.index ["name"], name: "lit_party_normalized_types_name_key", unique: true
  end

  create_table "lit_party_outcome_subtypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
  end

  create_table "lit_party_outcome_type_subtype_map", id: :serial, force: :cascade do |t|
    t.integer "lit_party_outcome_type_id"
    t.integer "lit_party_outcome_subtype_id"
    t.index ["lit_party_outcome_type_id", "lit_party_outcome_subtype_id"], name: "uniq_lit_party_outcome_type_subtype_map", unique: true
  end

  create_table "lit_party_outcome_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64
    t.text "description"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
  end

  create_table "lit_party_outcomes", id: :serial, force: :cascade do |t|
    t.integer "lit_parties_id"
    t.integer "lit_party_outcome_type_id"
    t.integer "lit_party_outcome_subtype_id"
    t.text "comments"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "updated_by", limit: 64
    t.integer "docket_entry_reference"
    t.index ["docket_entry_reference"], name: "index_lit_party_outcomes_on_docket_entry_reference"
  end

  create_table "lit_party_outcomes_deleted", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "lit_parties_id"
    t.integer "lit_party_outcome_type_id"
    t.integer "lit_party_outcome_subtype_id"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "updated_by", limit: 64
    t.integer "docket_entry_reference"
  end

  create_table "lit_party_types", id: :serial, comment: "Lit party type ID (1-143; key connects to lit_parties)", force: :cascade, comment: "Litigation party type (defendant, plaintiff, etc.) (docketx: representation.litigationtype)" do |t|
    t.string "name", limit: 255, null: false, comment: "Name of lit party type (e.g. plaintiff, defendant, counter defendant, etc.) (docketx: representation.litigationtype)"
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.string "lit_party_normalized_type", limit: 255, default: "unknown"
    t.index ["name"], name: "lit_party_types_name_unique_idx", unique: true
  end

  create_table "lit_pat_family_ids", primary_key: "lit_id", id: :integer, default: nil, force: :cascade do |t|
    t.integer "pat_family_ids", array: true
    t.index "pat_family_ids gin__int_ops", name: "lit_pat_family_ids_pat_family_ids_idx", using: :gin
  end

  create_table "lit_relationship_types", id: :serial, force: :cascade, comment: "Types of relationships between litigations (transfer, etc.)" do |t|
    t.string "name", limit: 255, null: false, comment: "Type of relationship (transfer, etc.)"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "lit_relationship_types_name_unique_idx", unique: true
  end

  create_table "lit_relationships", id: :serial, force: :cascade, comment: "Table to keep track of transfers, related cases" do |t|
    t.integer "from_lit_id", null: false, comment: "Litigation ID a transfer came from (key to link to lits)"
    t.integer "to_lit_id", null: false, comment: "Litigation ID a transfer went to (key to link to lits)"
    t.integer "lit_relationship_type_id", null: false, comment: "Type of relationship"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.integer "lit_family_id"
    t.string "created_by", default: -> { "(\"session_user\"())::character varying" }
    t.string "updated_by", default: -> { "(\"session_user\"())::character varying" }
    t.index ["from_lit_id", "to_lit_id"], name: "lit_relationships__from_lit_id_to_lit_id_uniq_idx", unique: true
    t.index ["from_lit_id"], name: "lit_relationships_fkey_from_lit_id"
    t.index ["lit_family_id"], name: "lit_relationships_lit_family_id_idx"
    t.index ["lit_relationship_type_id"], name: "lit_relationships_fkey_lit_relationship_type_id"
    t.index ["to_lit_id"], name: "lit_relationships_fkey_to_lit_id"
  end

  create_table "lit_relationships_deleted", id: false, force: :cascade do |t|
    t.integer "from_lit_id"
    t.integer "to_lit_id"
    t.integer "lit_relationship_type_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "id"
    t.integer "lit_family_id"
  end

  create_table "lit_stages", id: :serial, force: :cascade, comment: "Stage the litigation has reached (data01: rpx_stagereached_case.case_stagereached)" do |t|
    t.string "name", limit: 255, null: false, comment: "Stage a litigation has reached (data01: rpx_stagereached_case.case_stagereached)\n\ninitial_pleadings\nscheduling\nclaim_construction\ndispositive_motions\npretrial\ntrial\nposttrial\nunknown"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.index ["name"], name: "lit_stages_name_unique_idx", unique: true
  end

  create_table "lit_types", id: :serial, force: :cascade, comment: "Type of case (data01: rpx_casedata.case_type)" do |t|
    t.string "name", limit: 255, null: false, comment: "this looks like an overloaded field. (data01: rpx_casedata.case_type)\n\n 12710 | Operating Company\n  3487 | NPE\n   938 | INV\n   935 | False Marking\n   196 | Misfile\n   143 | Miscellaneous\n   107 | NCE\n    97 | UNI\n    54 | Ownership Dispute\n    47 | Administrative\n    10 | Trademark\n     8 | Pat Term Adjustment\n     5 | Filed in Error\n     1 | Copyright"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.string "description", limit: 255
    t.index ["name"], name: "lit_types_name_unique_idx", unique: true
  end

  create_table "lits", id: :serial, comment: "Litigation ID", force: :cascade, comment: "Litigations main docket information (docketx: districtdocket)" do |t|
    t.string "docketx_id", limit: 32, comment: "DocketX ID (docketx: districtdocket.id)"
    t.string "case_key", limit: 32, null: false, comment: "A composed natural primary key of the form  \"priorsmartCourtDistrictAcronym-caseID\" (e.g. \"casdce-362965\") which we get from the priorsmart_mapping spreadsheet. (docketx: districtdocket.pacerid)"
    t.integer "lit_cause_id", comment: "Cause type from PACER (key connects to lit_cause_types)  (docketx: districtdocket.cause)"
    t.integer "nos", null: false, comment: "Nature of Suit - 3 digit code (most will be 830) (docketx:districtdocket.nos)"
    t.decimal "demand", precision: 16, scale: 2, comment: "Monetary demand from plaintiff (docketx: districtdocket.demand)"
    t.string "docket_number", limit: 13, comment: "Docket case number (docketx: districtdocket.docketcasenumber)"
    t.string "docket_number_long", limit: 128, comment: "Docket case number with judges initials added (docketx: districtdocket.docketcasenumberlong)"
    t.string "jurisdiction", limit: 40, comment: "Federal Question\nU.S. Government Defendant\nU.S. Government Plaintiff\nDiversity\n(docketx: districtdocket.jurisdiction)"
    t.string "jury_demand", limit: 30, comment: "14991 | Plaintiff\n  9311 | Both\n  5543 | None\n  2064 | Defendant\n    50 | \n    11 | Unknown\n     2 | Either\n\n(docketx: districtdocket.jurydemand)"
    t.date "filed_date", null: false, comment: "Complaint filing date\n(docketx: districtdocket.datefiled)"
    t.date "closed_date", comment: "Date case is closed\n(docketx: districtdocket.dateclosed)"
    t.date "judgment_date", comment: "Judgement date (docketx: districtdocket.datejudgement)"
    t.date "decided_date", comment: "Decided date (docketx: districtdocket.datedecided)"
    t.date "reopened_date", comment: "Date case re-opened (districtdocket.datereopened)"
    t.date "disposed_date", comment: "Date case disposed (doxketx: districtdocket. datedisposed)"
    t.boolean "is_open", null: false, comment: "True if docketx: districtdocket.status == \"Open\", false if \"Closed\""
    t.string "title", limit: 255, null: false, comment: "Case title (docketx: courtcase.fullcasetitle)"
    t.string "case_type", limit: 2, comment: "Case type portion of the docket case number (docketx: courtcase.casetype)"
    t.datetime "last_pacer_retrieval_for_summary", comment: "Time of last PACER update"
    t.datetime "last_pacer_retrieval_for_docket", comment: "Time of last PACER docket update"
    t.datetime "last_pacer_retrieval_for_parties", comment: "Time of last PACER parties update"
    t.boolean "has_spammy_parties", default: false, comment: "true : If the parties have names which can trigger spam filters. To be used for sending email"
    t.boolean "has_spammy_patents", default: false, comment: "true : If patent has any word that would trigger spam filter. To be used for sending emails from portal in future.."
    t.boolean "has_complaint", default: false, comment: "True : If the docket has complaint"
    t.datetime "added_at", comment: "Time when the docket is added to the priorsmart Database. Would not be present for dockets imported from docketx."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.integer "docket_info_id", comment: "id from intakedb (key to link to docket information in raw/intake database)"
    t.boolean "is_administratively_closed", default: false, null: false, comment: "Was case closed for administrative reasons? (From Priorsmart)"
    t.string "salesforce_id", limit: 18
    t.date "original_filed_date", null: false, comment: "Automatically controlled by the database. The oldest filed date from any case this litigation may have been transferred from. If not a transfer then same as filed_date"
    t.boolean "pacer_docket_not_found", default: false
    t.boolean "pacer_docket_is_sealed", default: false
    t.boolean "is_dcl_corrected"
    t.index "title gin_trgm_ops", name: "lits_lower_title_gin_idx", using: :gin
    t.index "title gist_trgm_ops", name: "lits_title_idx", using: :gist
    t.index ["case_key"], name: "lit_case_key_unique_idx", unique: true
    t.index ["created_at"], name: "lits__created_at_idx"
    t.index ["docket_number"], name: "core_lits_docket_number_id"
    t.index ["updated_at"], name: "lits__updated_at_idx"
  end

  create_table "lits_deleted", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "docketx_id", limit: 32
    t.string "case_key", limit: 32
    t.integer "lit_cause_id"
    t.integer "nos"
    t.decimal "demand", precision: 16, scale: 2
    t.string "docket_number", limit: 13
    t.string "docket_number_long", limit: 128
    t.string "jurisdiction", limit: 40
    t.string "jury_demand", limit: 30
    t.date "filed_date"
    t.date "closed_date"
    t.date "judgment_date"
    t.date "decided_date"
    t.date "reopened_date"
    t.date "disposed_date"
    t.boolean "is_open"
    t.string "title", limit: 255
    t.string "case_type", limit: 2
    t.datetime "last_pacer_retrieval_for_summary"
    t.datetime "last_pacer_retrieval_for_docket"
    t.datetime "last_pacer_retrieval_for_parties"
    t.boolean "has_spammy_parties"
    t.boolean "has_spammy_patents"
    t.boolean "has_complaint"
    t.datetime "added_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "docket_info_id"
    t.boolean "is_administratively_closed"
    t.string "salesforce_id", limit: 18
    t.date "original_filed_date"
    t.boolean "pacer_docket_not_found"
    t.boolean "pacer_docket_is_sealed"
    t.boolean "is_dcl_corrected"
  end

  create_table "lits_pats_map", id: :serial, force: :cascade, comment: "Table to house the list of patent numbers (stripped_patnum) involved in litigations." do |t|
    t.integer "lit_id", null: false, comment: "Litigation id of the litigation the respective patent was named in.  Comment updated at: 2012-11-06"
    t.string "patnum", limit: 15, null: false, comment: "This is the stripped_patnum. It is NOT a patnum as in pats.patnum. To join with core.pats use lits_pats_map.patnum = pats.stripped_patnum. Comment updated at: 2012-11-06"
    t.date "start_date", comment: "INCORRECT: This column currently does not represent correct data with regards to the start and end date of the patent in suit. DO NOT USE. Comment updated at: 2012-11-06"
    t.date "end_date", comment: "INCORRECT: This column currently does not represent correct data with regards to the start and end date of the patent in suit. DO NOT USE. Comment updated at: 2012-11-06"
    t.datetime "created_at", default: -> { "(now())::timestamp without time zone" }, null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.string "salesforce_id", limit: 18
    t.string "created_by", limit: 255
    t.index ["lit_id", "patnum"], name: "lits_pats_map__lit_id_patnum_uniq_idx", unique: true
    t.index ["lit_id"], name: "lits_pats_map_fkey_lit_id"
    t.index ["patnum"], name: "lits_pats_map__patnum_idx"
  end

  create_table "lits_pats_map_deleted", id: false, force: :cascade do |t|
    t.integer "lit_id"
    t.string "patnum", limit: 15
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "id"
    t.string "salesforce_id", limit: 18
    t.string "created_by"
  end

  create_table "lits_pats_other", id: :serial, force: :cascade do |t|
    t.integer "lit_id", null: false
    t.integer "pat_id", null: false
    t.string "stripped_patnum", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by"
    t.index ["lit_id", "pat_id"], name: "lits_pats_other_lit_id_pat_id_idx", unique: true
    t.index ["lit_id"], name: "lits_pats_other_lit_id_idx"
    t.index ["pat_id"], name: "lits_pats_other_pat_id_idx"
    t.index ["stripped_patnum"], name: "lits_pats_other_stripped_patnum_idx"
  end

  create_table "log_data", force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data__app_id__run_id_idx"
    t.index ["app_name"], name: "log_data__app_name_idx"
    t.index ["log_level_id", "created_at"], name: "log_data__log_level_id__created_at_idx"
  end

  create_table "log_data", force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data__app_id__run_id_idx"
    t.index ["app_name"], name: "log_data__app_name_idx"
    t.index ["log_level_id", "created_at"], name: "log_data__log_level_id__created_at_idx"
  end

  create_table "log_data_201701", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201701_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201701_created_at_idx"
  end

  create_table "log_data_201702", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201702_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201702_created_at_idx"
  end

  create_table "log_data_201703", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201703_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201703_created_at_idx"
  end

  create_table "log_data_201704", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201704_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201704_created_at_idx"
  end

  create_table "log_data_201705", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201705_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201705_created_at_idx"
  end

  create_table "log_data_201706", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201706_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201706_created_at_idx"
  end

  create_table "log_data_201707", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201707_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201707_created_at_idx"
  end

  create_table "log_data_201708", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201708_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201708_created_at_idx"
  end

  create_table "log_data_201709", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201709_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201709_created_at_idx"
  end

  create_table "log_data_201710", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201710_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201710_created_at_idx"
  end

  create_table "log_data_201711", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201711_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201711_created_at_idx"
  end

  create_table "log_data_201712", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('log_data_id_seq'::regclass)" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.index ["app_id", "run_id"], name: "log_data_201712_created_app_run_idx"
    t.index ["created_at"], name: "log_data_201712_created_at_idx"
  end

  create_table "m_a_history__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "application__c", limit: 18
    t.string "brief_description__c", limit: 765
    t.datetime "date__c"
    t.string "divestiture_or_acquisition__c", limit: 255
    t.string "entity_name__c", limit: 240
    t.decimal "value_of_deal__c", precision: 24, scale: 6
    t.string "year__c", limit: 12
    t.string "brief_description_verified__c", limit: 765
    t.datetime "date_verified__c"
    t.string "divestiture_or_acquisition_ver", limit: 255
    t.string "entityname_verified__c", limit: 18
    t.decimal "value_of_deal_verified__c", precision: 24, scale: 6
    t.string "year_verified__c", limit: 12
    t.index ["id"], name: "um_a_history__c", unique: true
  end

  create_table "manual_assets", id: :serial, force: :cascade do |t|
    t.string "client", limit: 200
    t.string "run_date", limit: 30
    t.string "case_number", limit: 200
    t.string "country", limit: 200
    t.string "wipo", limit: 200
    t.string "subcase", limit: 200
    t.string "client_division", limit: 200
    t.string "case_type", limit: 200
    t.string "status", limit: 200
    t.string "application_number", limit: 200
    t.date "filing_date"
    t.string "patent_number", limit: 200
    t.date "issue_date"
    t.string "publication_number", limit: 200
    t.date "publication_date"
    t.date "expiration_date"
    t.text "title"
    t.string "db_comments", limit: 20
    t.string "db_query", limit: 500
    t.integer "core_pats_id"
    t.integer "docdb_pats_id"
    t.string "acquisition_id", limit: 20
    t.string "portfolio_id", limit: 50
    t.string "right_type", limit: 200
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.string "batch_number", limit: 30
    t.string "patnum", limit: 32
    t.string "originating_state_designated_asset"
    t.integer "acquisition_patent_id"
    t.index ["patent_number", "country"], name: "manual_assets_patnum_country_idx"
  end

  create_table "market_sector_portfolios_map", id: false, force: :cascade do |t|
    t.integer "portfolio_id"
    t.integer "market_sector_id"
    t.string "market_sector_name", limit: 255
    t.serial "id", null: false
  end

  create_table "market_sector_types", id: :serial, comment: "Market sector type ID (key connects to lit_annotations and ents_market_sector_types)", force: :cascade, comment: "RPX market sector codes (1-18) (data01: rpx_casedata.marketsector)" do |t|
    t.string "name", limit: 255, null: false, comment: "Name of market sector"
    t.datetime "updated_at", null: false, comment: "Date and time the record was last updated. Controlled automatically by the database."
    t.datetime "created_at", null: false, comment: "Date and time the record was created. Controlled automatically by the database."
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
    t.string "description", limit: 255
    t.string "key_value"
    t.index ["name"], name: "market_sector_types_name_unique_idx", unique: true
  end

  create_table "mc_license_date_3677_dump", id: false, force: :cascade do |t|
    t.integer "member_credit_history_id"
    t.date "license_date"
  end

  create_table "mc_tech_description_3709_dump", id: false, force: :cascade do |t|
    t.integer "member_credit_history_id"
    t.text "new_technology_description"
  end

  create_table "memory_integrity_assets_dump_round", id: false, force: :cascade do |t|
    t.integer "id"
    t.text "patent_number_raw"
    t.text "publication_number_raw"
    t.text "application_number_raw"
    t.text "country"
    t.text "title"
    t.text "asset_status"
    t.date "filed_date"
    t.date "publication_date"
    t.date "issue_date"
    t.date "expiration_date"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
  end

  create_table "mi_request__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 80
    t.string "currencyisocode", limit: 255
    t.string "recordtypeid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "assigned__c", limit: 18
    t.string "companies_to_include_in_analys", limit: 255
    t.string "company_name__c", limit: 18
    t.datetime "completed_date__c"
    t.datetime "expected_completion_date__c"
    t.string "mi_priority_manual_override__c", limit: 255
    t.text "mi_priority__c"
    t.datetime "meeting_date__c"
    t.text "notes__c"
    t.string "primary_market_sector__c", limit: 255
    t.string "priority__c", limit: 255
    t.decimal "ranking__c", precision: 12, scale: 3
    t.datetime "request_date__c"
    t.string "request_subtype__c", limit: 255
    t.string "request_type__c", limit: 255
    t.string "requested_by__c", limit: 18
    t.datetime "requested_completion_date__c"
    t.string "short_project_description__c", limit: 50
    t.string "status_notes__c", limit: 255
    t.string "status__c", limit: 255
    t.text "uw_category__c"
    t.string "opportunity__c", limit: 18
    t.index ["id"], name: "umi_request__c", unique: true
  end

  create_table "missing_lit_pat_numbers", id: false, force: :cascade do |t|
    t.string "patnum"
  end

  create_table "morpho_camera_assets_dump", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "cpi_tracking_status_id"
    t.text "patent_number_raw"
    t.text "publication_number_raw"
    t.text "application_number_raw"
    t.text "country"
    t.text "title"
    t.text "asset_status"
    t.date "filed_date"
    t.date "publication_date"
    t.date "issue_date"
    t.text "current_assignee"
    t.text "annuity_fee_status"
    t.date "expiration_date"
    t.text "notes"
    t.text "type"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
  end

  create_table "movi_assets_dump", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "family"
    t.text "patent_number_raw"
    t.text "publication_number_raw"
    t.text "application_number_raw"
    t.text "country"
    t.text "title"
    t.text "application_status"
    t.text "filed_date_actual"
    t.text "publication_date_actual"
    t.text "issue_date_actual"
    t.text "current_assignee"
    t.text "annuity_fee_status"
    t.date "expiration_date"
    t.text "notes"
    t.text "type"
    t.text "upload_status"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
    t.string "publication_number", limit: 2048
    t.date "filed_date"
    t.date "publication_date"
    t.date "issue_date"
  end

  create_table "msg_queue", primary_key: "msg_id", id: :serial, force: :cascade, comment: "This table is the intake queue for the DMA. Items are poped from this queue and added to the DMA and then logged in the msg_queue_log." do |t|
    t.string "msg_key", limit: 100, null: false
    t.text "msg_body", null: false, comment: "A json representation of the data that needs to be disambiguated/tagged in the DMA."
    t.datetime "create_tsp", default: "2011-10-28 06:33:31", null: false
    t.integer "priority", limit: 2, default: 1, null: false, comment: "Priority in which items are popped from the Queue by the DMA. The greaters integers are popped first."
    t.string "push_client", default: "UNKNOWN", null: false
    t.integer "msg_type"
    t.index ["msg_type", "msg_id", "priority"], name: "msg_queue_type_id_pri_idx"
  end

  create_table "msg_queue_log", id: false, force: :cascade do |t|
    t.integer "msg_id"
    t.string "msg_key", limit: 100
    t.text "msg_body"
    t.datetime "create_tsp"
    t.integer "priority", limit: 2
    t.datetime "org_create_tsp", null: false
    t.integer "msg_type"
    t.string "push_client", limit: 20, null: false
  end

  create_table "non_party_entity__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "opportunity__c", limit: 18
    t.string "account__c", limit: 18
    t.text "notes__c"
    t.string "source__c", limit: 255
    t.string "acquisition_opportunity__c", limit: 18
    t.datetime "date_assertion_letter_received"
    t.string "asserting_entity__c", limit: 18
    t.string "int_l_jurisdiction__c", limit: 255
    t.datetime "litigation_start_date__c"
    t.datetime "litigation_end_date__c"
    t.index ["id"], name: "unon_party_entity__c", unique: true
  end

  create_table "northstar_assets_dump", id: false, force: :cascade do |t|
    t.integer "id"
    t.text "patent_number_raw"
    t.text "application_number_raw"
    t.text "application_status"
    t.text "country"
    t.text "filed_date_actual"
    t.text "title"
    t.text "upload_status"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
    t.date "filed_date"
  end

  create_table "oma_mismatch", id: false, force: :cascade do |t|
    t.string "acquisition_opportunity__c", limit: 18
    t.integer "id"
  end

  create_table "oma_patent__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "acquisition_opportunity__c", limit: 18
    t.string "patent__c", limit: 18
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "ispatnum_text__c", limit: 5
    t.string "patentnumber__c", limit: 765
    t.datetime "insight_updated_time__c"
    t.string "stripped_patnum__c", limit: 15
    t.index ["acquisition_opportunity__c"], name: "oma_patent__c_acquisition_opportunity__c_idx"
    t.index ["id"], name: "uoma_patent__c", unique: true
    t.index ["stripped_patnum__c", "acquisition_opportunity__c"], name: "idx_oma_patent_stripped_patnum_aoid"
  end

  create_table "opportunity", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "accountid", limit: 18
    t.string "recordtypeid", limit: 18
    t.string "isprivate", limit: 5
    t.string "namex", limit: 360
    t.text "description"
    t.string "stagename", limit: 255
    t.decimal "amount", precision: 22, scale: 6
    t.decimal "probability", precision: 3
    t.decimal "expectedrevenue", precision: 22, scale: 6
    t.decimal "totalopportunityquantity", precision: 18, scale: 2
    t.datetime "closedate"
    t.string "typex", limit: 255
    t.string "nextstep", limit: 765
    t.string "leadsource", limit: 255
    t.string "isclosed", limit: 5
    t.string "iswon", limit: 5
    t.string "forecastcategory", limit: 255
    t.string "forecastcategoryname", limit: 255
    t.string "currencyisocode", limit: 255
    t.string "campaignid", limit: 18
    t.string "hasopportunitylineitem", limit: 5
    t.string "pricebook2id", limit: 18
    t.string "ownerid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.decimal "fiscalquarter"
    t.decimal "fiscalyear"
    t.string "fiscal", limit: 6
    t.string "opportunity_type__c", limit: 255
    t.decimal "discount__c", precision: 5, scale: 2
    t.text "private_deal_notes__c"
    t.decimal "historical_rate__c", precision: 24, scale: 6
    t.string "priority__c", limit: 255
    t.text "analysis_notes__c"
    t.text "deal_notes__c"
    t.datetime "bids_due__c"
    t.string "lead_source_2__c", limit: 180
    t.text "triage_comments__c"
    t.string "source_del__c", limit: 18
    t.string "seller_claims_charts__c", limit: 5
    t.text "current_status__c"
    t.text "portfolio_summary__c"
    t.datetime "start_date__c"
    t.string "seller_loop_closed__c", limit: 5
    t.text "analysis_recommendation__c"
    t.string "seller_s_expectation__c", limit: 300
    t.string "nda__c", limit: 5
    t.string "outside_analysis__c", limit: 150
    t.text "deal_summary__c"
    t.decimal "rpx_rate__c", precision: 21, scale: 6
    t.string "sales_materials_sent__c", limit: 765
    t.datetime "due_date__c"
    t.text "technology_area__c"
    t.string "rpx_project_code__c", limit: 90
    t.string "analysis_assigned_to__c", limit: 18
    t.text "key_patent_s_and_claims__c"
    t.string "best_patent_s__c", limit: 765
    t.datetime "earliest_priority__c"
    t.text "legal_notes__c"
    t.text "seller_notes__c"
    t.text "prospect_member_notes__c"
    t.decimal "who_cares__c", precision: 18
    t.decimal "scariness__c", precision: 18
    t.text "summary__c"
    t.string "quick_opinion__c", limit: 255
    t.string "companies_who_care__c", limit: 765
    t.string "ease_of_detection__c", limit: 255
    t.string "quick_recommendation__c", limit: 255
    t.text "analysis_explanation__c"
    t.string "action_item_assigned_to__c", limit: 150
    t.text "analysis_next_steps__c"
    t.string "target_quarter__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "claims_charts_provided__c", limit: 765
    t.string "licensees__c", limit: 765
    t.text "outside_expert_analysis__c"
    t.string "analysis_stage__c", limit: 255
    t.text "portfolio_patents__c"
    t.decimal "yearly_rate_per_contract__c", precision: 8
    t.decimal "manual_back_fee__c", precision: 22, scale: 6
    t.string "report_toggle__c", limit: 5
    t.string "quarter__c", limit: 255
    t.text "industry_relevance__c"
    t.text "last_action__c"
    t.string "confidential_rpx_eyes_only__c", limit: 5
    t.string "degree_of_dialogue__c", limit: 255
    t.string "deal_probability__c", limit: 255
    t.text "confidential_working_notes__c"
    t.string "confidentiality_level__c", limit: 255
    t.string "send_update_notifications__c", limit: 255
    t.string "verbose_notifications__c", limit: 255
    t.decimal "actual_back_fee__c", precision: 22, scale: 6
    t.decimal "actual_member_payment_back_fee", precision: 22, scale: 6
    t.decimal "actual_rate__c", precision: 22, scale: 6
    t.decimal "amortization_period__c", precision: 2
    t.decimal "calculated_back_fees__c", precision: 22, scale: 6
    t.decimal "discount_amount__c", precision: 22, scale: 6
    t.decimal "discount_full_hidden__c", precision: 18, scale: 15
    t.decimal "rpx_rate_card_from_account__c", precision: 22, scale: 6
    t.decimal "rpx_rate_card_at_deal_close__c", precision: 22, scale: 6
    t.text "rate_details__c"
    t.string "rpx_busdev_priority__c", limit: 255
    t.string "previous_action__c", limit: 765
    t.string "rejected_deal_primary_reason", limit: 255
    t.text "rejected_deal_secondary_reason"
    t.string "top_prospect__c", limit: 5
    t.string "aon_commission__c", limit: 255
    t.decimal "current_vesting_period__c", precision: 2
    t.decimal "membership_term__c", precision: 2
    t.text "win_loss_code__c"
    t.string "yearly_back_fee_override__c", limit: 5
    t.string "company_participation_status", limit: 255
    t.string "rpx_opportunityid__c", limit: 90
    t.datetime "purchase_date__c"
    t.text "comments__c"
    t.string "equity_type__c", limit: 255
    t.string "named_attorney_1__c", limit: 18
    t.string "named_attorney_2__c", limit: 18
    t.string "named_attorney_3__c", limit: 18
    t.string "named_attorney_4__c", limit: 18
    t.string "aon_contact_2__c", limit: 18
    t.string "named_law_firm_1__c", limit: 18
    t.string "named_law_firm_2__c", limit: 18
    t.string "named_law_firm_3__c", limit: 18
    t.string "named_law_firm_4__c", limit: 18
    t.string "aon_contact_3__c", limit: 18
    t.string "aon_contact_2_role__c", limit: 255
    t.string "aon_contact_3_role__c", limit: 255
    t.string "deal_comments__c", limit: 765
    t.text "term_expiration_quarter__c"
    t.string "aon_introduction_made__c", limit: 255
    t.string "patents_in_suit__c", limit: 18
    t.string "datapoints__c", limit: 765
    t.text "rpx_relationship__c"
    t.text "account_s_primary_market_secto"
    t.string "rpx_administrator__c", limit: 18
    t.string "rpx_facilitator__c", limit: 18
    t.datetime "date_of_aon_intro_meeting__c"
    t.string "suit_ranking__c", limit: 255
    t.string "analysis_requested__c", limit: 5
    t.string "candidate_for_syndication__c", limit: 5
    t.string "characterization_of_claims__c", limit: 765
    t.text "claim_terms_and_construction"
    t.string "claims_previously_construed__c", limit: 5
    t.string "claims_previously_held_invalid", limit: 5
    t.string "deal_type__c", limit: 255
    t.datetime "expiration_date__c"
    t.text "licensing_and_ownership_histor"
    t.text "overview_of_prior_art_and_sour"
    t.string "rights_type__c", limit: 255
    t.text "litigation_forecast__c"
    t.string "dataroom_required__c", limit: 255
    t.decimal "account_s_current_revenue__c", precision: 18
    t.string "licensing_advisor__c", limit: 18
    t.datetime "analysis_completed__c"
    t.string "previous_analysis_notes__c", limit: 765
    t.string "standards_based__c", limit: 5
    t.string "market_sector_detail__c", limit: 255
    t.datetime "analysis_start_date__c"
    t.string "contingent_payment_obligations", limit: 255
    t.string "finders_fee_commission_payment", limit: 255
    t.string "field_of_use_limitations__c", limit: 255
    t.string "future_incentive_payments_to_p", limit: 255
    t.string "client_specific_exclusions__c", limit: 255
    t.string "other_non_standard_provisions", limit: 255
    t.string "contingency_payment_detail__c", limit: 765
    t.string "finders_fee_commission_detail", limit: 765
    t.string "field_of_use_limitation_detail", limit: 765
    t.string "future_incentive_payments_deta", limit: 765
    t.string "client_specific_exlusions_deta", limit: 765
    t.string "other_non_standard_provision0", limit: 765
    t.string "litigation_history__c", limit: 765
    t.decimal "amortization_period_renewal__c", precision: 3
    t.decimal "annual_member_payment__c", precision: 24, scale: 6
    t.decimal "avoided_cost_000s__c", precision: 16, scale: 6
    t.decimal "current_roi_prorated__c", precision: 5
    t.decimal "current_roi__c", precision: 5
    t.datetime "current_term_effective_date__c"
    t.datetime "current_term_expiration_date"
    t.decimal "current_term__c", precision: 2
    t.string "heat_map__c", limit: 255
    t.datetime "initial_effective_date__c"
    t.decimal "initial_term__c", precision: 2
    t.datetime "new_term_effective_date__c"
    t.text "notes__c"
    t.decimal "notification_term_for_non_rene", precision: 3
    t.string "payment_schedule__c", limit: 255
    t.decimal "proposed_new_term_yrs__c", precision: 3
    t.text "publicity_rights_exception__c"
    t.string "roi_last_updated__c", limit: 765
    t.decimal "yearly_back_fee__c", precision: 16, scale: 6
    t.string "call_schedule__c", limit: 255
    t.string "prioritization__c", limit: 255
    t.datetime "date_roi_confirmed__c"
    t.string "roi_confirmed__c", limit: 255
    t.string "previous_invoice_amounts__c", limit: 765
    t.string "system_rate_last_updated__c", limit: 150
    t.text "close_quarter__c"
    t.string "lid__linkedin_company_id__c", limit: 240
    t.string "hub_opportunity__c", limit: 18
    t.decimal "of_us_patents_input__c", precision: 10
    t.string "close_driver__c", limit: 255
    t.decimal "no_of_non_us_patents_input__c", precision: 10
    t.decimal "no_of_non_us_applications_inpu", precision: 18
    t.decimal "no_of_us_applications_input__c", precision: 10
    t.string "contact1__c", limit: 18
    t.string "identified_litigation__c", limit: 300
    t.string "current_status_sa__c", limit: 765
    t.string "opportunity_source__c", limit: 255
    t.string "explored_ip_insurance_before", limit: 255
    t.decimal "proposed_vesting_period__c", precision: 2
    t.text "explored_terms__c"
    t.string "budgeting_cycle__c", limit: 255
    t.string "flexibility_with_broker_cycle", limit: 255
    t.decimal "insurance_budget__c", precision: 24, scale: 6
    t.string "insurance_purchasor__c", limit: 255
    t.text "rate_card__c"
    t.decimal "standard_2013_rate__c", precision: 22, scale: 6
    t.string "contingent_on_litigation__c", limit: 255
    t.decimal "per_claim_retention__c", precision: 24, scale: 6
    t.decimal "co_pay__c", precision: 3
    t.decimal "per_claim_limit__c", precision: 24, scale: 6
    t.decimal "aggregate_limit__c", precision: 24, scale: 6
    t.decimal "actual_member_payment__c", precision: 22, scale: 6
    t.decimal "risk_based_price_discount__c", precision: 18, scale: 2
    t.datetime "risk_based_price_expiration_da"
    t.decimal "aggregate_retention__c", precision: 24, scale: 6
    t.string "corporate_insurance_broker__c", limit: 255
    t.text "insurance_win_loss_code__c"
    t.text "litigation_details__c"
    t.text "system_rate_last_updated_1__c"
    t.string "special_provisions__c", limit: 765
    t.string "dataroom_created__c", limit: 255
    t.string "can_share_name__c", limit: 255
    t.string "anonymous_plaintiff__c", limit: 255
    t.string "attached_all_relevant_sales_ma", limit: 5
    t.datetime "automatic_roi_last_updated__c"
    t.datetime "contracteffectivedate__c"
    t.decimal "contract_roi__c", precision: 18
    t.string "hub_acquisition__c", limit: 18
    t.text "heat_map_color__c"
    t.decimal "invoiced_roi__c", precision: 18
    t.decimal "last_12_months_roi__c", precision: 18
    t.decimal "prorated_roi__c", precision: 18
    t.text "recordtype__c"
    t.string "specified_publicity_on_account", limit: 5
    t.string "dataroom_expected__c", limit: 255
    t.string "corresponding_acquisition_id", limit: 54
    t.string "close_date_change_reason__c", limit: 255
    t.string "close_date_change_comments__c", limit: 765
    t.decimal "annual_premium__c", precision: 24, scale: 6
    t.decimal "option_fee__c", precision: 16, scale: 6
    t.decimal "bundle_discount__c", precision: 24, scale: 6
    t.decimal "annual_rpx_membership_fee__c", precision: 24, scale: 6
    t.decimal "pricing_subtotal__c", precision: 22, scale: 6
    t.decimal "rrg_investment__c", precision: 24, scale: 6
    t.decimal "total_fee__c", precision: 24, scale: 6
    t.string "close_driver_comments__c", limit: 765
    t.string "dormant_code__c", limit: 255
    t.datetime "date_quoted__c"
    t.decimal "bundle_discount_percent__c", precision: 18, scale: 1
    t.decimal "upsell_rate__c", precision: 24, scale: 6
    t.string "next_steps__c", limit: 765
    t.decimal "net_membership_fee__c", precision: 24, scale: 6
    t.string "next_underwriting_milestone__c", limit: 255
    t.datetime "need_by__c"
    t.string "presentation_required__c", limit: 255
    t.text "comments_for_underwriters__c"
    t.string "tech_related_lits__c", limit: 5
    t.text "tech_related_lit_s_list__c"
    t.decimal "option_cost_to_rpx__c", precision: 16, scale: 6
    t.string "tech_related_lits_updated__c", limit: 300
    t.string "cr_cd_action_items__c", limit: 765
    t.string "potential_rpx_benefit__c", limit: 765
    t.string "aon_primary_contact__c", limit: 18
    t.string "aon_primary_contact_role__c", limit: 255
    t.datetime "date_of_aon_approval__c"
    t.datetime "expiration_of_aon_approval__c"
    t.string "benchmarking_type__c", limit: 255
    t.text "roi_notes__c"
    t.datetime "roi_last_presented__c"
    t.string "client_portal__c", limit: 7
    t.string "litigation_clearance__c", limit: 7
    t.string "roi__c", limit: 7
    t.string "open_market_acq_s__c", limit: 7
    t.string "syndications__c", limit: 7
    t.string "intelligence__c", limit: 7
    t.string "conferences__c", limit: 7
    t.string "networking__c", limit: 7
    t.string "insurance__c", limit: 7
    t.string "collaborative_defense__c", limit: 7
    t.string "entertainment__c", limit: 7
    t.string "defensive_option__c", limit: 7
    t.string "vesting_option__c", limit: 5
    t.string "other_value_drivers__c", limit: 765
    t.text "hot_buttons_sensitivities__c"
    t.string "feedback_for_oma__c", limit: 5
    t.string "feedback_for_lits__c", limit: 5
    t.string "is_feedback_timely__c", limit: 5
    t.string "feedback_obtainability_notes", limit: 765
    t.text "list_of_troubling_issues__c"
    t.text "plan_to_resolve_issues__c"
    t.text "resources_needed_for_resolutio"
    t.text "member_s_approval_process__c"
    t.text "plan_to_get_to_decision_makers"
    t.text "current_relationship_status__c"
    t.string "policy_type__c", limit: 255
    t.string "vesting__c", limit: 255
    t.decimal "weighted_rate__c", precision: 22, scale: 6
    t.decimal "lits_filed_this_year", precision: 18
    t.decimal "lits_filed_this_past_year", precision: 18
    t.decimal "lits_filed_past_5_years_active", precision: 18
    t.string "underwriter__c", limit: 255
    t.datetime "next_step_last_mod__c"
    t.text "support_team_engaged__c"
    t.string "contact_2__c", limit: 18
    t.string "contact_3__c", limit: 18
    t.string "contact_2_role__c", limit: 255
    t.string "contact_3_role__c", limit: 255
    t.string "primary_contact__c", limit: 18
    t.string "primary_contact_role__c", limit: 255
    t.decimal "most_recent_annual_fee__c", precision: 24, scale: 6
    t.decimal "priority_tier__c", precision: 18
    t.decimal "prospect_score__c", precision: 18
    t.string "est_rate_floor__c", limit: 765
    t.datetime "est_rate_floor_last_modified"
    t.decimal "outreach_tier__c", precision: 1
    t.string "materials_presented__c", limit: 255
    t.string "agreement_sent__c", limit: 255
    t.string "participant_contact__c", limit: 120
    t.datetime "last_date_contacted__c"
    t.decimal "standard_2014_rate__c", precision: 22, scale: 6
    t.string "patent_prior_art__c", limit: 255
    t.string "related_litigation__c", limit: 255
    t.string "other_restrictions__c", limit: 765
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "ip_team_size__c", limit: 255
    t.string "ip_team_description__c", limit: 765
    t.string "introduction_made__c", limit: 255
    t.datetime "date_of_intro_meeting__c"
    t.datetime "date_of_approval__c"
    t.datetime "expiration_of_approval__c"
    t.string "broker_partner_account__c", limit: 18
    t.string "broker_partner_type__c", limit: 255
    t.string "original_source__c", limit: 255
    t.string "engagement_begun__c", limit: 255
    t.string "competing_bids__c", limit: 255
    t.string "broker_contact__c", limit: 18
    t.text "tier_type__c"
    t.string "pricing_indication__c", limit: 255
    t.string "underwriterlookup__c", limit: 18
    t.text "candidate_for__c"
    t.text "local_counsel_venue__c"
    t.decimal "standard_2015_rate__c", precision: 24, scale: 6
    t.string "finc_services_outreach_2015__c", limit: 5
    t.string "excess_outreach_2015__c", limit: 5
    t.string "p1_mem_outreach_2015__c", limit: 5
    t.string "syncedquoteid", limit: 18
    t.datetime "subscription_start_date__c"
    t.datetime "subscription_end_date__c"
    t.datetime "trial_start_date__c"
    t.datetime "trial_end_date__c"
    t.datetime "next_outreach_date__c"
    t.string "subscription_tier__c", limit: 255
    t.string "litigation__c", limit: 18
    t.string "assets__c", limit: 18
    t.index ["accountid"], name: "idx_sf_opportunity_account"
    t.index ["accountid"], name: "idx_sf_opportunity_accountid"
    t.index ["id"], name: "uopportunity", unique: true
  end

  create_table "opportunity_acquisition_archived", id: false, force: :cascade do |t|
    t.integer "etl_id"
    t.string "delete_flag", limit: 1
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "accountid", limit: 18
    t.string "recordtypeid", limit: 18
    t.string "isprivate", limit: 5
    t.string "namex", limit: 360
    t.text "description"
    t.string "stagename", limit: 255
    t.decimal "amount", precision: 22, scale: 6
    t.decimal "probability", precision: 3
    t.decimal "expectedrevenue", precision: 22, scale: 6
    t.decimal "totalopportunityquantity", precision: 18, scale: 2
    t.datetime "closedate"
    t.string "typex", limit: 255
    t.string "nextstep", limit: 765
    t.string "leadsource", limit: 255
    t.string "isclosed", limit: 5
    t.string "iswon", limit: 5
    t.string "forecastcategory", limit: 255
    t.string "forecastcategoryname", limit: 255
    t.string "currencyisocode", limit: 255
    t.string "campaignid", limit: 18
    t.string "hasopportunitylineitem", limit: 5
    t.string "pricebook2id", limit: 18
    t.string "ownerid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.decimal "fiscalquarter"
    t.decimal "fiscalyear"
    t.string "fiscal", limit: 6
    t.string "opportunity_type__c", limit: 255
    t.decimal "discount__c", precision: 5, scale: 2
    t.text "private_deal_notes__c"
    t.decimal "historical_rate__c", precision: 24, scale: 6
    t.string "priority__c", limit: 255
    t.text "analysis_notes__c"
    t.text "deal_notes__c"
    t.datetime "bids_due__c"
    t.string "lead_source_2__c", limit: 180
    t.text "triage_comments__c"
    t.string "source_del__c", limit: 18
    t.string "seller_claims_charts__c", limit: 5
    t.text "current_status__c"
    t.text "portfolio_summary__c"
    t.datetime "start_date__c"
    t.string "seller_loop_closed__c", limit: 5
    t.text "analysis_recommendation__c"
    t.string "seller_s_expectation__c", limit: 300
    t.string "nda__c", limit: 5
    t.string "outside_analysis__c", limit: 150
    t.text "deal_summary__c"
    t.decimal "rpx_rate__c", precision: 21, scale: 6
    t.string "sales_materials_sent__c", limit: 765
    t.datetime "due_date__c"
    t.text "technology_area__c"
    t.string "rpx_project_code__c", limit: 90
    t.string "analysis_assigned_to__c", limit: 18
    t.text "key_patent_s_and_claims__c"
    t.string "best_patent_s__c", limit: 765
    t.datetime "earliest_priority__c"
    t.text "legal_notes__c"
    t.text "seller_notes__c"
    t.text "prospect_member_notes__c"
    t.decimal "who_cares__c", precision: 18
    t.decimal "scariness__c", precision: 18
    t.text "summary__c"
    t.string "quick_opinion__c", limit: 255
    t.string "companies_who_care__c", limit: 765
    t.string "ease_of_detection__c", limit: 255
    t.string "quick_recommendation__c", limit: 255
    t.text "analysis_explanation__c"
    t.string "action_item_assigned_to__c", limit: 150
    t.text "analysis_next_steps__c"
    t.string "target_quarter__c", limit: 255
    t.string "primary_market_sector__c", limit: 255
    t.string "claims_charts_provided__c", limit: 765
    t.string "licensees__c", limit: 765
    t.text "outside_expert_analysis__c"
    t.string "analysis_stage__c", limit: 255
    t.text "portfolio_patents__c"
    t.decimal "yearly_rate_per_contract__c", precision: 8
    t.decimal "manual_back_fee__c", precision: 22, scale: 6
    t.string "report_toggle__c", limit: 5
    t.string "quarter__c", limit: 255
    t.text "industry_relevance__c"
    t.text "last_action__c"
    t.string "confidential_rpx_eyes_only__c", limit: 5
    t.string "degree_of_dialogue__c", limit: 255
    t.string "deal_probability__c", limit: 255
    t.text "confidential_working_notes__c"
    t.string "confidentiality_level__c", limit: 255
    t.string "send_update_notifications__c", limit: 255
    t.string "verbose_notifications__c", limit: 255
    t.decimal "actual_back_fee__c", precision: 22, scale: 6
    t.decimal "actual_member_payment_back_fee", precision: 22, scale: 6
    t.decimal "actual_rate__c", precision: 22, scale: 6
    t.decimal "amortization_period__c", precision: 2
    t.decimal "calculated_back_fees__c", precision: 22, scale: 6
    t.decimal "discount_amount__c", precision: 22, scale: 6
    t.decimal "discount_full_hidden__c", precision: 18, scale: 15
    t.decimal "rpx_rate_card_from_account__c", precision: 22, scale: 6
    t.decimal "rpx_rate_card_at_deal_close__c", precision: 22, scale: 6
    t.text "rate_details__c"
    t.string "rpx_busdev_priority__c", limit: 255
    t.string "previous_action__c", limit: 765
    t.string "rejected_deal_primary_reason", limit: 255
    t.text "rejected_deal_secondary_reason"
    t.string "top_prospect__c", limit: 5
    t.string "aon_commission__c", limit: 255
    t.decimal "current_vesting_period__c", precision: 2
    t.decimal "membership_term__c", precision: 2
    t.text "win_loss_code__c"
    t.string "yearly_back_fee_override__c", limit: 5
    t.string "company_participation_status", limit: 255
    t.string "rpx_opportunityid__c", limit: 90
    t.datetime "purchase_date__c"
    t.text "comments__c"
    t.string "equity_type__c", limit: 255
    t.string "named_attorney_1__c", limit: 18
    t.string "named_attorney_2__c", limit: 18
    t.string "named_attorney_3__c", limit: 18
    t.string "named_attorney_4__c", limit: 18
    t.string "aon_contact_2__c", limit: 18
    t.string "named_law_firm_1__c", limit: 18
    t.string "named_law_firm_2__c", limit: 18
    t.string "named_law_firm_3__c", limit: 18
    t.string "named_law_firm_4__c", limit: 18
    t.string "aon_contact_3__c", limit: 18
    t.string "aon_contact_2_role__c", limit: 255
    t.string "aon_contact_3_role__c", limit: 255
    t.string "deal_comments__c", limit: 765
    t.text "term_expiration_quarter__c"
    t.string "aon_introduction_made__c", limit: 255
    t.string "patents_in_suit__c", limit: 18
    t.string "datapoints__c", limit: 765
    t.text "rpx_relationship__c"
    t.text "account_s_primary_market_secto"
    t.string "rpx_administrator__c", limit: 18
    t.string "rpx_facilitator__c", limit: 18
    t.datetime "date_of_aon_intro_meeting__c"
    t.string "suit_ranking__c", limit: 255
    t.string "analysis_requested__c", limit: 5
    t.string "candidate_for_syndication__c", limit: 5
    t.string "characterization_of_claims__c", limit: 765
    t.text "claim_terms_and_construction"
    t.string "claims_previously_construed__c", limit: 5
    t.string "claims_previously_held_invalid", limit: 5
    t.string "deal_type__c", limit: 255
    t.datetime "expiration_date__c"
    t.text "licensing_and_ownership_histor"
    t.text "overview_of_prior_art_and_sour"
    t.string "rights_type__c", limit: 255
    t.text "litigation_forecast__c"
    t.string "dataroom_required__c", limit: 255
    t.decimal "account_s_current_revenue__c", precision: 18
    t.string "licensing_advisor__c", limit: 18
    t.datetime "analysis_completed__c"
    t.string "previous_analysis_notes__c", limit: 765
    t.string "standards_based__c", limit: 5
    t.string "market_sector_detail__c", limit: 255
    t.datetime "analysis_start_date__c"
    t.string "contingent_payment_obligations", limit: 255
    t.string "finders_fee_commission_payment", limit: 255
    t.string "field_of_use_limitations__c", limit: 255
    t.string "future_incentive_payments_to_p", limit: 255
    t.string "client_specific_exclusions__c", limit: 255
    t.string "other_non_standard_provisions", limit: 255
    t.string "contingency_payment_detail__c", limit: 765
    t.string "finders_fee_commission_detail", limit: 765
    t.string "field_of_use_limitation_detail", limit: 765
    t.string "future_incentive_payments_deta", limit: 765
    t.string "client_specific_exlusions_deta", limit: 765
    t.string "other_non_standard_provision0", limit: 765
    t.string "litigation_history__c", limit: 765
    t.decimal "amortization_period_renewal__c", precision: 3
    t.decimal "annual_member_payment__c", precision: 24, scale: 6
    t.decimal "avoided_cost_000s__c", precision: 16, scale: 6
    t.decimal "current_roi_prorated__c", precision: 5
    t.decimal "current_roi__c", precision: 5
    t.datetime "current_term_effective_date__c"
    t.datetime "current_term_expiration_date"
    t.decimal "current_term__c", precision: 2
    t.string "heat_map__c", limit: 255
    t.datetime "initial_effective_date__c"
    t.decimal "initial_term__c", precision: 2
    t.datetime "new_term_effective_date__c"
    t.text "notes__c"
    t.decimal "notification_term_for_non_rene", precision: 3
    t.string "payment_schedule__c", limit: 255
    t.decimal "proposed_new_term_yrs__c", precision: 3
    t.text "publicity_rights_exception__c"
    t.string "roi_last_updated__c", limit: 765
    t.decimal "yearly_back_fee__c", precision: 16, scale: 6
    t.string "call_schedule__c", limit: 255
    t.string "prioritization__c", limit: 255
    t.datetime "date_roi_confirmed__c"
    t.string "roi_confirmed__c", limit: 255
    t.string "previous_invoice_amounts__c", limit: 765
    t.string "system_rate_last_updated__c", limit: 150
    t.text "close_quarter__c"
    t.string "lid__linkedin_company_id__c", limit: 240
    t.string "hub_opportunity__c", limit: 18
    t.decimal "of_us_patents_input__c", precision: 10
    t.string "close_driver__c", limit: 255
    t.decimal "no_of_non_us_patents_input__c", precision: 10
    t.decimal "no_of_non_us_applications_inpu", precision: 18
    t.decimal "no_of_us_applications_input__c", precision: 10
    t.string "contact1__c", limit: 18
    t.string "identified_litigation__c", limit: 300
    t.string "current_status_sa__c", limit: 765
    t.string "opportunity_source__c", limit: 255
    t.string "explored_ip_insurance_before", limit: 255
    t.decimal "proposed_vesting_period__c", precision: 2
    t.text "explored_terms__c"
    t.string "budgeting_cycle__c", limit: 255
    t.string "flexibility_with_broker_cycle", limit: 255
    t.decimal "insurance_budget__c", precision: 24, scale: 6
    t.string "insurance_purchasor__c", limit: 255
    t.text "rate_card__c"
    t.decimal "standard_2013_rate__c", precision: 22, scale: 6
    t.string "contingent_on_litigation__c", limit: 255
    t.decimal "per_claim_retention__c", precision: 24, scale: 6
    t.decimal "co_pay__c", precision: 3
    t.decimal "per_claim_limit__c", precision: 24, scale: 6
    t.decimal "aggregate_limit__c", precision: 24, scale: 6
    t.decimal "actual_member_payment__c", precision: 22, scale: 6
    t.decimal "risk_based_price_discount__c", precision: 18, scale: 2
    t.datetime "risk_based_price_expiration_da"
    t.decimal "aggregate_retention__c", precision: 24, scale: 6
    t.string "corporate_insurance_broker__c", limit: 255
    t.text "insurance_win_loss_code__c"
    t.text "litigation_details__c"
    t.text "system_rate_last_updated_1__c"
    t.string "special_provisions__c", limit: 765
    t.string "dataroom_created__c", limit: 255
    t.string "can_share_name__c", limit: 255
    t.string "anonymous_plaintiff__c", limit: 255
    t.string "attached_all_relevant_sales_ma", limit: 5
    t.datetime "automatic_roi_last_updated__c"
    t.datetime "contracteffectivedate__c"
    t.decimal "contract_roi__c", precision: 18
    t.string "hub_acquisition__c", limit: 18
    t.text "heat_map_color__c"
    t.decimal "invoiced_roi__c", precision: 18
    t.decimal "last_12_months_roi__c", precision: 18
    t.decimal "prorated_roi__c", precision: 18
    t.text "recordtype__c"
    t.string "specified_publicity_on_account", limit: 5
    t.string "dataroom_expected__c", limit: 255
    t.string "corresponding_acquisition_id", limit: 54
    t.string "close_date_change_reason__c", limit: 255
    t.string "close_date_change_comments__c", limit: 765
    t.decimal "annual_premium__c", precision: 24, scale: 6
    t.decimal "option_fee__c", precision: 16, scale: 6
    t.decimal "bundle_discount__c", precision: 24, scale: 6
    t.decimal "annual_rpx_membership_fee__c", precision: 24, scale: 6
    t.decimal "pricing_subtotal__c", precision: 22, scale: 6
    t.decimal "rrg_investment__c", precision: 24, scale: 6
    t.decimal "total_fee__c", precision: 24, scale: 6
    t.string "close_driver_comments__c", limit: 765
    t.string "dormant_code__c", limit: 255
    t.datetime "date_quoted__c"
    t.decimal "bundle_discount_percent__c", precision: 18, scale: 1
    t.decimal "upsell_rate__c", precision: 24, scale: 6
    t.string "next_steps__c", limit: 765
    t.decimal "net_membership_fee__c", precision: 24, scale: 6
    t.string "next_underwriting_milestone__c", limit: 255
    t.datetime "need_by__c"
    t.string "presentation_required__c", limit: 255
    t.text "comments_for_underwriters__c"
    t.string "tech_related_lits__c", limit: 5
    t.text "tech_related_lit_s_list__c"
    t.decimal "option_cost_to_rpx__c", precision: 16, scale: 6
    t.string "tech_related_lits_updated__c", limit: 300
    t.string "cr_cd_action_items__c", limit: 765
    t.string "potential_rpx_benefit__c", limit: 765
    t.string "aon_primary_contact__c", limit: 18
    t.string "aon_primary_contact_role__c", limit: 255
    t.datetime "date_of_aon_approval__c"
    t.datetime "expiration_of_aon_approval__c"
    t.string "benchmarking_type__c", limit: 255
    t.text "roi_notes__c"
    t.datetime "roi_last_presented__c"
    t.string "client_portal__c", limit: 7
    t.string "litigation_clearance__c", limit: 7
    t.string "roi__c", limit: 7
    t.string "open_market_acq_s__c", limit: 7
    t.string "syndications__c", limit: 7
    t.string "intelligence__c", limit: 7
    t.string "conferences__c", limit: 7
    t.string "networking__c", limit: 7
    t.string "insurance__c", limit: 7
    t.string "collaborative_defense__c", limit: 7
    t.string "entertainment__c", limit: 7
    t.string "defensive_option__c", limit: 7
    t.string "vesting_option__c", limit: 5
    t.string "other_value_drivers__c", limit: 765
    t.text "hot_buttons_sensitivities__c"
    t.string "feedback_for_oma__c", limit: 5
    t.string "feedback_for_lits__c", limit: 5
    t.string "is_feedback_timely__c", limit: 5
    t.string "feedback_obtainability_notes", limit: 765
    t.text "list_of_troubling_issues__c"
    t.text "plan_to_resolve_issues__c"
    t.text "resources_needed_for_resolutio"
    t.text "member_s_approval_process__c"
    t.text "plan_to_get_to_decision_makers"
    t.text "current_relationship_status__c"
    t.string "policy_type__c", limit: 255
    t.string "vesting__c", limit: 255
    t.decimal "weighted_rate__c", precision: 22, scale: 6
    t.decimal "lits_filed_this_year", precision: 18
    t.decimal "lits_filed_this_past_year", precision: 18
    t.decimal "lits_filed_past_5_years_active", precision: 18
    t.string "underwriter__c", limit: 255
    t.datetime "next_step_last_mod__c"
    t.text "support_team_engaged__c"
    t.string "contact_2__c", limit: 18
    t.string "contact_3__c", limit: 18
    t.string "contact_2_role__c", limit: 255
    t.string "contact_3_role__c", limit: 255
    t.string "primary_contact__c", limit: 18
    t.string "primary_contact_role__c", limit: 255
    t.decimal "most_recent_annual_fee__c", precision: 24, scale: 6
    t.decimal "priority_tier__c", precision: 18
    t.decimal "prospect_score__c", precision: 18
    t.string "est_rate_floor__c", limit: 765
    t.datetime "est_rate_floor_last_modified"
    t.decimal "outreach_tier__c", precision: 1
    t.string "materials_presented__c", limit: 255
    t.string "agreement_sent__c", limit: 255
    t.string "participant_contact__c", limit: 120
    t.datetime "last_date_contacted__c"
    t.decimal "standard_2014_rate__c", precision: 22, scale: 6
    t.string "patent_prior_art__c", limit: 255
    t.string "related_litigation__c", limit: 255
    t.string "other_restrictions__c", limit: 765
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "ip_team_size__c", limit: 255
    t.string "ip_team_description__c", limit: 765
    t.string "introduction_made__c", limit: 255
    t.datetime "date_of_intro_meeting__c"
    t.datetime "date_of_approval__c"
    t.datetime "expiration_of_approval__c"
    t.string "broker_partner_account__c", limit: 18
    t.string "broker_partner_type__c", limit: 255
    t.string "original_source__c", limit: 255
    t.string "engagement_begun__c", limit: 255
    t.string "competing_bids__c", limit: 255
    t.string "broker_contact__c", limit: 18
    t.text "tier_type__c"
    t.string "pricing_indication__c", limit: 255
    t.string "underwriterlookup__c", limit: 18
    t.text "candidate_for__c"
    t.text "local_counsel_venue__c"
    t.decimal "standard_2015_rate__c", precision: 24, scale: 6
    t.string "finc_services_outreach_2015__c", limit: 5
    t.string "excess_outreach_2015__c", limit: 5
    t.string "p1_mem_outreach_2015__c", limit: 5
    t.string "syncedquoteid", limit: 18
    t.datetime "subscription_start_date__c"
    t.datetime "subscription_end_date__c"
    t.datetime "trial_start_date__c"
    t.datetime "trial_end_date__c"
    t.datetime "next_outreach_date__c"
    t.string "subscription_tier__c", limit: 255
    t.string "litigation__c", limit: 18
    t.string "assets__c", limit: 18
  end

  create_table "opportunity_litigation__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "opportunity__c", limit: 18
    t.string "litigation__c", limit: 18
    t.string "acquisition_opportunity__c", limit: 18
    t.text "case_name__c"
    t.text "case_phase__c"
    t.text "docket_number__c"
    t.datetime "filed__c"
    t.text "lead_defendant__c"
    t.text "plaintiff__c"
    t.decimal "no_of_defendants__c", precision: 18
    t.decimal "no_of_active_defendants__c", precision: 18
    t.text "court__c"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.decimal "count__c", precision: 18
    t.decimal "n_defendants_active__c", precision: 18
    t.decimal "n_defendants_terminated__c", precision: 18
    t.decimal "n_defendants__c", precision: 18
    t.decimal "n_members_active__c", precision: 18
    t.decimal "n_members_terminated__c", precision: 18
    t.decimal "n_members__c", precision: 18
    t.decimal "n_prospects_active__c", precision: 18
    t.decimal "n_prospects_terminated__c", precision: 18
    t.decimal "n_prospects__c", precision: 18
    t.datetime "acquisition_created_date__c"
    t.datetime "close_date__c"
    t.string "litigation_id__c", limit: 765
    t.string "litigation_name__c", limit: 765
    t.string "casekey__c", limit: 765
    t.datetime "closedate__c"
    t.string "court_n__c", limit: 765
    t.string "docketnumber__c", limit: 765
    t.datetime "filed_date__c"
    t.text "litigation_url__c"
    t.datetime "insight_updated_time__c"
    t.index ["acquisition_opportunity__c"], name: "idx_opportunity_litigation_ao_id"
    t.index ["id"], name: "uopportunity_litigation__c", unique: true
    t.index ["litigation__c", "acquisition_opportunity__c"], name: "acq_opp_2_lit_acq_opp_lit_idx"
    t.index ["litigation_id__c"], name: "idx_opportunity_litigation__c_litigation_id"
  end

  create_table "opportunityfieldhistory", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "opportunityid", limit: 18
    t.string "createdbyid", limit: 18
    t.datetime "createddate"
    t.string "field", limit: 255
    t.string "oldvalue", limit: 765
    t.string "newvalue", limit: 765
    t.index ["id"], name: "uopportunityfieldhistory", unique: true
  end

  create_table "opportunityhistory", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "opportunityid", limit: 18
    t.string "createdbyid", limit: 18
    t.datetime "createddate"
    t.string "stagename", limit: 255
    t.decimal "amount", precision: 22, scale: 6
    t.decimal "expectedrevenue", precision: 22, scale: 6
    t.datetime "closedate"
    t.decimal "probability", precision: 3
    t.string "forecastcategory", limit: 255
    t.string "currencyisocode", limit: 255
    t.datetime "systemmodstamp"
    t.string "isdeleted", limit: 5
    t.index ["id"], name: "uopportunityhistory", unique: true
  end

  create_table "opportunityhistory_acquisition_archived", id: false, force: :cascade do |t|
    t.integer "etl_id"
    t.string "delete_flag", limit: 1
    t.string "id", limit: 18
    t.string "opportunityid", limit: 18
    t.string "createdbyid", limit: 18
    t.datetime "createddate"
    t.string "stagename", limit: 255
    t.decimal "amount", precision: 22, scale: 6
    t.decimal "expectedrevenue", precision: 22, scale: 6
    t.datetime "closedate"
    t.decimal "probability", precision: 3
    t.string "forecastcategory", limit: 255
    t.string "currencyisocode", limit: 255
    t.datetime "systemmodstamp"
    t.string "isdeleted", limit: 5
    t.string "corresponding_acquisition_id", limit: 54
  end

  create_table "option_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "option_types_19jan_2016", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "options__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.string "account__c", limit: 18
    t.string "acquisition__c", limit: 18
    t.datetime "effective_date__c"
    t.datetime "expiration_date__c"
    t.text "expires_in_of_days__c"
    t.decimal "cost_to_rpx__c", precision: 15, scale: 6
    t.text "notes__c"
    t.text "timing__c"
    t.string "trigger__c", limit: 765
    t.text "name_as_listed__c"
    t.string "acquisition_as_listed__c", limit: 210
    t.string "legal_lead__c", limit: 60
    t.string "exercised__c", limit: 5
    t.index ["id"], name: "uoptions__c", unique: true
  end

  create_table "options_report_download_requests", id: :serial, force: :cascade do |t|
    t.text "email", null: false
    t.datetime "requested_at"
    t.boolean "report_sent", default: false
    t.datetime "report_sent_at"
    t.integer "acquisition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizationx", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "namex", limit: 240
    t.string "division", limit: 240
    t.string "street", limit: 765
    t.string "city", limit: 120
    t.string "statex", limit: 60
    t.string "postalcode", limit: 60
    t.string "country", limit: 120
    t.string "phone", limit: 120
    t.string "fax", limit: 120
    t.string "primarycontact", limit: 240
    t.string "defaultlocalesidkey", limit: 255
    t.string "languagelocalekey", limit: 255
    t.string "receivesinfoemails", limit: 5
    t.string "receivesadmininfoemails", limit: 5
    t.string "preferencesrequireopportunityp", limit: 5
    t.decimal "fiscalyearstartmonth"
    t.string "usesstartdateasfiscalyearname", limit: 5
    t.string "defaultaccountaccess", limit: 255
    t.string "defaultcontactaccess", limit: 255
    t.string "defaultopportunityaccess", limit: 255
    t.string "defaultleadaccess", limit: 255
    t.string "defaultcaseaccess", limit: 255
    t.string "defaultcalendaraccess", limit: 255
    t.string "defaultpricebookaccess", limit: 255
    t.string "defaultcampaignaccess", limit: 255
    t.string "delegatedauthenticationservice", limit: 765
    t.datetime "systemmodstamp"
    t.string "compliancebccemail", limit: 240
    t.string "uiskin", limit: 255
    t.datetime "trialexpirationdate"
    t.string "organizationtype", limit: 255
    t.string "webtocasedefaultorigin", limit: 120
    t.decimal "monthlypageviewsused"
    t.decimal "monthlypageviewsentitlement"
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "updated_at"
    t.datetime "created_at"
    t.decimal "latitude", precision: 18, scale: 15
    t.decimal "longitude", precision: 18, scale: 15
    t.decimal "totaltrustedrequestslimit"
    t.decimal "totaltrustedrequestsusage"
    t.text "address"
    t.string "signupcountryisocode", limit: 2
    t.index ["id"], name: "uorganizationx", unique: true
  end

  create_table "pat_abstracts", id: :serial, force: :cascade, comment: "Paragraph briefly describing invention from high level.\ntds:abst" do |t|
    t.integer "pat_id", null: false
    t.text "abstract_text", comment: "tds:atxt\nAbstract Text paragraphs"
    t.string "lang", limit: 2, comment: "language code of the abstract"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "word_count"
    t.index ["pat_id"], name: "pat_abstracts_pat_id_idx", unique: true
  end

  create_table "pat_assignment_attachments", id: :serial, force: :cascade, comment: "we capture the Path of pdf and OCR for the patent assignements. the parsed output of few fields generally found on first page are captured as columns " do |t|
    t.integer "assignment_id", null: false
    t.string "correspondent_phone", limit: 255
    t.string "correspondent_email", limit: 255
    t.string "correspondent_name", limit: 512
    t.string "correspondent_address_line_1", limit: 255
    t.string "correspondent_address_line_2", limit: 255
    t.string "correspondent_address_line_3", limit: 255
    t.string "correspondent_address_line_4", limit: 255
    t.string "submitter_name", limit: 512
    t.string "submitter_signature", limit: 512
    t.date "submitter_date_signed"
    t.string "s3_pdf_url", limit: 255
    t.string "s3_ocr_url", limit: 255
    t.datetime "created_at", default: -> { "clock_timestamp()" }
    t.string "created_by", limit: 255
    t.datetime "updated_at", default: -> { "clock_timestamp()" }
    t.string "updated_by", limit: 255
    t.string "ocr_exception", limit: 1000
    t.string "parsing_exception", limit: 1000
    t.boolean "is_parsed", default: false
    t.index ["assignment_id"], name: "pat_assignment_attachments_assignment_id_idx"
    t.index ["s3_pdf_url"], name: "pat_assignment_attachments_s3_pdf_url_idx"
  end

  create_table "pat_assignments", id: :serial, force: :cascade, comment: "tds:assi" do |t|
    t.integer "reel_number", default: 0, null: false, comment: "The reel number according the  USPTO. If the reel number = 0, the assignment is \"the name on the face of the Patent\" and not an actually recorded assignment on USPTO. Comment updated at: 2012-11-06"
    t.integer "frame_number", default: 0, null: false, comment: "The frame number according the  USPTO. If the frame number = 0, the assignment is \"the name on the face of the Patent\" and not an actually recorded assignment on USPTO. Comment updated at: 2012-11-06"
    t.date "recorded_date", comment: "The recordation date of the given assignment according to the USPTO. Comment updated at: 2012-11-06"
    t.integer "correspondent_alias_id", comment: "The alias id of the correspondent of the given assignment. Maps to the alias table. Comment updated at: 2012-11-06"
    t.text "conveyance", comment: "The \"as listed\" conveyance for the given assignment according to the USPTO. Comment updated at: 2012-11-06"
    t.integer "page_count"
    t.boolean "is_purged", default: false, null: false, comment: "record indicator from PTO"
    t.boolean "is_transaction", default: false, null: false, comment: "RPX calculated field - means patent changed hands"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "correspondent_alias_contact_id", comment: "The alias contact if for the correspondent for the given assignment. This maps to the alias_contacts table.  Comment updated at: 2012-11-06"
    t.boolean "is_verified", default: false, null: false, comment: "If the correspondent alias_id match to an entity has been verified.  Comment updated at: 2012-11-06"
    t.text "notes"
    t.string "verified_by", limit: 255, comment: "Who verified the correspondent alias_id match to an entity. Comment updated at: 2012-11-06"
    t.integer "pat_assignment_file_id"
    t.integer "primary_conveyance_logic_id", default: -1, null: false
    t.integer "primary_conveyance_logic_version", default: -1, null: false
    t.integer "primary_conveyance_type_id", default: -1, null: false
    t.integer "associated_reel_frame_status", default: 0, null: false
    t.integer "secondary_conveyance_logic_version", default: 0, null: false
    t.boolean "possible_secondary_conveyance", default: true, null: false
    t.boolean "is_dcl_corrected"
    t.index "((created_at)::date)", name: "idx_pat_assignments_created_at_date"
    t.index ["conveyance"], name: "idx_pat_assignments_conveyance"
    t.index ["correspondent_alias_id"], name: "pat_assignments_fkey_correspondent_alias_id"
    t.index ["created_at"], name: "pat_assignments__created_at_idx"
    t.index ["primary_conveyance_logic_version"], name: "pat_assignments_pr_logic_version"
    t.index ["primary_conveyance_type_id"], name: "pat_assignments_primary_conveyance_type_id_idx"
    t.index ["primary_conveyance_type_id"], name: "primary_conveyance_type_id_idx"
    t.index ["reel_number", "frame_number", "id"], name: "pat_assignments__reel_number_frame_number_id_uniq_idx", unique: true
    t.index ["secondary_conveyance_logic_version"], name: "pat_assignments_sec_logic_version"
    t.index ["updated_at"], name: "pat_assignments__updated_at_idx"
  end

  create_table "pat_assignments_assoc_r_f", id: :serial, force: :cascade, comment: "This table represents relationships between an assignment and other assignments that the aforementioned assignment references within the given assignment for the associated patent. The relation ship is 1 assignment to 1 to many related assignments.  Comment updated at: 2012-11-06" do |t|
    t.integer "pat_assignment_id", null: false, comment: "That assignment that is referencing other assignments. Comment updated at: 2012-11-06"
    t.integer "reel", null: false, comment: "The reel of the current assignment referenced.  Comment updated at: 2012-11-06"
    t.integer "frame", null: false, comment: "The frame of the current assignment referenced.  Comment updated at: 2012-11-06"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "pat_bad_titles", id: false, force: :cascade do |t|
    t.integer "pat_id"
    t.text "title"
  end

  create_table "pat_claim_relationships", id: :serial, force: :cascade do |t|
    t.integer "pat_claims_id", null: false
    t.integer "depends_on", null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["pat_claims_id"], name: "pat_claim_relationships_fkey_pat_claims_id"
  end

  create_table "pat_claims", id: :serial, force: :cascade, comment: "tds:clms" do |t|
    t.integer "pat_id", null: false
    t.string "claim_num", limit: 20, null: false, comment: "tds:claim_num\nClaim number"
    t.text "claim_text", comment: "tds:ctxt\nClaim paragraph"
    t.string "lang", limit: 2
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "word_count"
    t.index ["id", "pat_id"], name: "idx_pat_claims_pat_claim_id"
    t.index ["pat_id", "claim_num"], name: "pat_claims_pat_id_claim_num_idx"
    t.index ["pat_id"], name: "pat_claims_fkey_pat_id"
  end

  create_table "pat_claims_s3", id: :serial, force: :cascade do |t|
    t.integer "pat_id"
    t.boolean "loaded_to_s3", default: false
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.index ["loaded_to_s3"], name: "pat_claims_s3_loaded_to_s3_idx"
    t.index ["pat_id"], name: "pat_claims_s3_pat_id_idx", unique: true
  end

  create_table "pat_cpc", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "country_code", limit: 32
    t.string "doc_kind_code", limit: 32
    t.string "application_number", limit: 32
    t.string "grant_pub_number", limit: 32
    t.integer "pat_id"
    t.string "cpc_section", limit: 32
    t.string "cpc_class", limit: 32
    t.string "cpc_subclass", limit: 32
    t.string "cpc_main_group", limit: 32
    t.string "separator", limit: 32
    t.string "cpc_subgroup", limit: 32
    t.date "cpc_version_date"
    t.string "cpc_symbol_position", limit: 32
    t.string "cpc_value_code", limit: 32
    t.string "cpc_comb_set_group_number", limit: 32
    t.string "cpc_comb_set_rank_number", limit: 32
    t.string "application_type", limit: 32
    t.string "md5_pat_cpc", limit: 32
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.index "((grant_pub_number)::bigint), application_type, md5_pat_cpc", name: "idx_pat_cpc_grant_pub_number_md5"
    t.index ["pat_id", "cpc_section"], name: "idx_pat_cpc_pat_section"
  end

  create_table "pat_cross_ref_classes", id: :serial, force: :cascade, comment: "tds:crcu" do |t|
    t.integer "pat_id", null: false
    t.string "cross_ref_element", limit: 20, null: false, comment: "tds:crun\nSingle cross-reference class element"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["pat_id", "cross_ref_element"], name: "pat_cross_ref_classes__pat_id_cross_ref_element_uniq_idx", unique: true
  end

  create_table "pat_current", primary_key: "app_num_country", id: :string, limit: 2048, force: :cascade do |t|
    t.integer "pat_id"
    t.string "patnum", limit: 255
    t.string "stripped_patnum", limit: 32
    t.integer "maintenance_code_id"
    t.serial "id", null: false
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["maintenance_code_id"], name: "idx_pat_current_maint_code_id"
    t.index ["pat_id"], name: "pat_current_pat_id_idx"
    t.index ["patnum"], name: "idx_patnum"
    t.index ["stripped_patnum"], name: "idx_pat_current_stripped_patnum"
  end

  create_table "pat_descriptions", id: :serial, force: :cascade, comment: "tds:descr" do |t|
    t.integer "pat_id", null: false
    t.string "lang", limit: 2, comment: "Language"
    t.text "description", comment: "Description"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "word_count"
    t.index ["pat_id"], name: "pat_descriptions_pat_id_idx", unique: true
  end

  create_table "pat_document_types", id: :serial, force: :cascade do |t|
    t.string "document_type", limit: 255, null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "is_default", default: false, null: false
  end

  create_table "pat_documents", id: :serial, force: :cascade, comment: "if the related doc is provisional application or related publication then this table else pat_related_docs" do |t|
    t.integer "pat_id", null: false
    t.string "country", limit: 255
    t.string "description", limit: 255
    t.string "doc_date", limit: 8
    t.string "doc_name", limit: 255
    t.string "doc_number", limit: 255
    t.string "doc_type", limit: 255
    t.string "kind", limit: 255
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
  end

  create_table "pat_drawings", id: :serial, force: :cascade, comment: "big zip files have embeded docs in them which this table points to" do |t|
    t.integer "pat_id", null: false
    t.string "alt", limit: 255, comment: "alternate title; eg \"embedded image\""
    t.string "figure_id", limit: 255
    t.text "file", comment: "filename of the image in big zip"
    t.string "img_content", limit: 255
    t.string "img_format", limit: 255
    t.string "img_id", limit: 255
    t.string "he", limit: 255, comment: "height"
    t.string "wi", limit: 255, comment: "width"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
  end

  create_table "pat_ent_relationships", id: :serial, force: :cascade do |t|
    t.integer "pat_id"
    t.integer "inventor_alias_ids", array: true
    t.integer "inventor_ent_ids", array: true
    t.integer "primary_examiner_alias_ids", array: true
    t.integer "primary_examiner_ent_ids", array: true
    t.integer "secondary_examiner_alias_ids", array: true
    t.integer "secondary_examiner_ent_ids", array: true
    t.integer "original_assignee_alias_ids", array: true
    t.integer "original_assignee_ent_ids", array: true
    t.integer "sponsoring_party_alias_ids", array: true
    t.integer "sponsoring_party_ent_ids", array: true
    t.integer "current_assignee_alias_ids", array: true
    t.integer "current_assignee_ent_ids", array: true
    t.integer "any_assignee_alias_ids", array: true
    t.integer "any_assignee_ent_ids", array: true
    t.integer "litigated_by_district_court_alias_ids", array: true
    t.integer "litigated_by_district_court_ent_ids", array: true
    t.integer "litigated_by_itc_alias_ids", array: true
    t.integer "litigated_by_itc_ent_ids", array: true
    t.integer "ptab_patent_owner_alias_ids", array: true
    t.integer "ptab_patent_owner_ent_ids", array: true
    t.integer "litigated_against_district_court_alias_ids", array: true
    t.integer "litigated_against_district_court_ent_ids", array: true
    t.integer "litigated_against_itc_alias_ids", array: true
    t.integer "litigated_against_itc_ent_ids", array: true
    t.integer "ptab_petitioner_alias_ids", array: true
    t.integer "ptab_petitioner_ent_ids", array: true
    t.integer "current_assignee_citation_alias_ids", array: true
    t.integer "current_assignee_citation_ent_ids", array: true
    t.integer "current_assignee_citee_alias_ids", array: true
    t.integer "current_assignee_citee_ent_ids", array: true
    t.integer "potentially_relevant_company_alias_ids", array: true
    t.integer "potentially_relevant_company_ent_ids", array: true
    t.integer "pa_web_licensee_alias_ids", array: true
    t.integer "pa_web_licensee_ent_ids", array: true
    t.integer "correspondent_alias_ids", array: true
    t.integer "correspondent_ent_ids", array: true
    t.datetime "created_at", default: -> { "now()" }
    t.string "created_by", limit: 255
    t.integer "run_id", default: 0
    t.datetime "updated_at", default: -> { "now()" }
    t.index "any_assignee_alias_ids gin__int_ops", name: "any_assignee_alias_id_gin_idx", using: :gin
    t.index "any_assignee_ent_ids gin__int_ops", name: "any_assignee_ent_id_gin_idx", using: :gin
    t.index "current_assignee_alias_ids gin__int_ops", name: "current_assignee_alias_id_gin_idx", using: :gin
    t.index "current_assignee_ent_ids gin__int_ops", name: "current_assignee_ent_id_gin_idx", using: :gin
    t.index "litigated_against_district_court_alias_ids gin__int_ops", name: "litigated_against_district_court_alias_id_gin_idx", using: :gin
    t.index "litigated_against_district_court_ent_ids gin__int_ops", name: "litigated_against_district_court_ent_id_gin_idx", using: :gin
    t.index "litigated_by_district_court_alias_ids gin__int_ops", name: "litigated_by_district_court_alias_id_gin_idx", using: :gin
    t.index "litigated_by_district_court_ent_ids gin__int_ops", name: "litigated_by_district_court_ent_id_gin_idx", using: :gin
    t.index "original_assignee_alias_ids gin__int_ops", name: "original_assignee_alias_id_gin_idx", using: :gin
    t.index "original_assignee_ent_ids gin__int_ops", name: "original_assignee_ent_id_gin_idx", using: :gin
    t.index ["pat_id"], name: "pat_ent_relationships_pat_ids_idx", unique: true
  end

  create_table "pat_ent_relationships_tmp", id: :serial, force: :cascade do |t|
    t.integer "pat_id"
    t.integer "inventor_alias_ids", array: true
    t.integer "inventor_ent_ids", array: true
    t.integer "primary_examiner_alias_ids", array: true
    t.integer "primary_examiner_ent_ids", array: true
    t.integer "secondary_examiner_alias_ids", array: true
    t.integer "secondary_examiner_ent_ids", array: true
    t.integer "original_assignee_alias_ids", array: true
    t.integer "original_assignee_ent_ids", array: true
    t.integer "sponsoring_party_alias_ids", array: true
    t.integer "sponsoring_party_ent_ids", array: true
    t.integer "current_assignee_alias_ids", array: true
    t.integer "current_assignee_ent_ids", array: true
    t.integer "any_assignee_alias_ids", array: true
    t.integer "any_assignee_ent_ids", array: true
    t.integer "litigated_by_district_court_alias_ids", array: true
    t.integer "litigated_by_district_court_ent_ids", array: true
    t.integer "litigated_by_itc_alias_ids", array: true
    t.integer "litigated_by_itc_ent_ids", array: true
    t.integer "ptab_patent_owner_alias_ids", array: true
    t.integer "ptab_patent_owner_ent_ids", array: true
    t.integer "litigated_against_district_court_alias_ids", array: true
    t.integer "litigated_against_district_court_ent_ids", array: true
    t.integer "litigated_against_itc_alias_ids", array: true
    t.integer "litigated_against_itc_ent_ids", array: true
    t.integer "ptab_petitioner_alias_ids", array: true
    t.integer "ptab_petitioner_ent_ids", array: true
    t.integer "current_assignee_citation_alias_ids", array: true
    t.integer "current_assignee_citation_ent_ids", array: true
    t.integer "current_assignee_citee_alias_ids", array: true
    t.integer "current_assignee_citee_ent_ids", array: true
    t.integer "potentially_relevant_company_alias_ids", array: true
    t.integer "potentially_relevant_company_ent_ids", array: true
    t.integer "pa_web_licensee_alias_ids", array: true
    t.integer "pa_web_licensee_ent_ids", array: true
    t.integer "correspondent_alias_ids", array: true
    t.integer "correspondent_ent_ids", array: true
    t.datetime "created_at", default: -> { "now()" }
    t.string "created_by", limit: 255
    t.integer "run_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.index ["any_assignee_alias_ids"], name: "any_assignee_alias_ids_gin_idx", using: :gin
    t.index ["current_assignee_alias_ids"], name: "current_assignee_alias_ids_gin_idx", using: :gin
    t.index ["current_assignee_ent_ids"], name: "current_assignee_ent_ids_gin_idx", using: :gin
    t.index ["litigated_against_district_court_alias_ids"], name: "litigated_against_district_court_alias_ids_gin_idx", using: :gin
    t.index ["litigated_against_district_court_ent_ids"], name: "litigated_against_district_court_ent_ids_gin_idx", using: :gin
    t.index ["litigated_by_district_court_alias_ids"], name: "litigated_by_district_court_alias_ids_gin_idx", using: :gin
    t.index ["litigated_by_district_court_ent_ids"], name: "litigated_by_district_court_ent_ids_gin_idx", using: :gin
    t.index ["original_assignee_alias_ids"], name: "original_assignee_alias_ids_gin_idx", using: :gin
    t.index ["original_assignee_ent_ids"], name: "original_assignee_ent_ids_gin_idx", using: :gin
    t.index ["pat_id"], name: "pat_ent_relationships_pat_id_idx", unique: true
  end

  create_table "pat_families", id: :serial, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "salesforce_id", limit: 18
    t.string "name", limit: 128
    t.date "priority_date"
    t.date "expiry_date"
    t.integer "us_patent_count"
    t.integer "us_application_count"
    t.integer "non_us_patent_count"
    t.integer "non_us_application_count"
    t.string "first_us_stripped_patnum", limit: 32
    t.index ["created_at"], name: "pat_families__created_at"
    t.index ["id", "priority_date"], name: "pat_families_id_priority_date_idx"
    t.index ["updated_at"], name: "pat_families__updated_at_idx"
  end

  create_table "pat_families_log", id: :serial, force: :cascade do |t|
    t.string "procedure", limit: 255
    t.string "chunk", limit: 255
    t.string "patnum", limit: 255
    t.text "error_msg"
    t.datetime "created_at", null: false
    t.integer "pat_family_id"
  end

  create_table "pat_family_match_log", id: :serial, force: :cascade do |t|
    t.string "procedure", limit: 255
    t.integer "core_pf_id"
    t.integer "docdb_pf_id"
    t.text "patnums_differ"
    t.boolean "docdb_updated", default: false
    t.text "error_msg"
    t.datetime "created_at", null: false
  end

  create_table "pat_family_pats", id: :serial, force: :cascade do |t|
    t.integer "pat_id"
    t.integer "pat_family_id"
    t.string "patnum", limit: 64
    t.string "stripped_patnum", limit: 32
    t.string "app_num_intl", limit: 64
    t.string "country_code", limit: 16
    t.date "app_date"
    t.string "core_patnum", limit: 64
    t.integer "core_pat_family_id"
    t.string "salesforce_id", limit: 18
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_current"
    t.index ["created_at"], name: "pat_family_pats__created_at"
    t.index ["pat_family_id"], name: "idx_pat_family_pats_pat_family_id"
    t.index ["pat_id"], name: "idx_pat_family_pats_id", unique: true
    t.index ["patnum"], name: "idx_pat_family_pats_patnum"
    t.index ["stripped_patnum", "country_code"], name: "pat_family_pats_stripped_patnum_country_idx"
  end

  create_table "pat_family_pats_details", id: :serial, force: :cascade do |t|
    t.integer "pat_id"
    t.string "patnum", limit: 32
    t.string "stripped_patnum", limit: 32
    t.string "country_code", limit: 16
    t.integer "pat_family_id"
    t.string "pat_family_name", limit: 128
    t.date "pat_family_priority_date"
    t.date "pat_family_expiry_date"
    t.integer "pat_family_us_patent_count"
    t.integer "pat_family_us_application_count"
    t.integer "pat_family_non_us_patent_count"
    t.integer "pat_family_non_us_application_count"
    t.string "pat_family_first_us_stripped_patnum", limit: 32
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "created_by"
    t.string "updated_by"
    t.index ["pat_family_id"], name: "idx_pat_family_pats_details_pat_family_id"
    t.index ["pat_id"], name: "pat_family_pats_details_idx_tmp"
    t.index ["stripped_patnum"], name: "pat_family_pats_details_stripped_patnum_idx"
  end

  create_table "pat_family_provisional_filings", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.integer "pat_family_id"
    t.string "provisional_filing_num", limit: 64
    t.date "app_date"
    t.string "created_by", limit: 32
    t.datetime "created_at", default: -> { "now()" }
    t.index ["pat_family_id"], name: "pat_family_provisional_filings_pat_family"
  end

  create_table "pat_ipc_classes", id: :serial, force: :cascade do |t|
    t.integer "pat_id", null: false
    t.string "name", limit: 255, null: false
    t.string "version", limit: 255, null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["pat_id", "name"], name: "pat_ipc_classes__pat_id__name_uniq_idx", unique: true
  end

  create_table "pat_lit_liklihood", id: false, force: :cascade do |t|
    t.integer "patent_id"
    t.decimal "bayesian_bridge"
    t.index ["patent_id"], name: "pat_lit_liklihood_patent_id_idx"
  end

  create_table "pat_litigation_likelihood_v1", id: false, force: :cascade do |t|
    t.integer "patent_id"
    t.decimal "bayesian_bridge"
  end

  create_table "pat_litigation_likelihood_v2", id: false, force: :cascade do |t|
    t.integer "patent_id"
    t.decimal "litigation_likelihood"
    t.serial "id", null: false
    t.index ["id"], name: "pat_litigation_likelihood_v2_id_idx"
    t.index ["patent_id"], name: "pat_litigation_likelihood_v2_patent_id_idx"
  end

  create_table "pat_maintenance_code", id: :integer, default: nil, force: :cascade do |t|
    t.string "code", limit: 2, null: false
    t.string "description", limit: 70, null: false
    t.string "created_by", limit: 255, null: false
    t.string "updated_by", limit: 255, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["code"], name: "idx_pat_maintenance_code_code", unique: true
  end

  create_table "pat_maintenance_fee_entity_types", id: :serial, force: :cascade do |t|
    t.string "code", limit: 1, null: false
    t.string "description", limit: 25, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "pat_maintenance_fee_event_types", id: :serial, force: :cascade do |t|
    t.string "code", limit: 5, null: false
    t.string "description", limit: 100, null: false
    t.boolean "is_important", default: false
    t.boolean "is_default", default: false
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
  end

  create_table "pat_maintenance_fee_events", id: :serial, force: :cascade do |t|
    t.integer "pat_id", null: false
    t.integer "pat_maintenance_fee_event_type_id", null: false
    t.integer "pat_maintenance_fee_entity_type_id", null: false
    t.date "event_date", null: false
    t.boolean "is_deleted", default: false
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.index ["pat_id"], name: "pat_maintenance_fee_events_fkey_pat_id"
    t.index ["pat_maintenance_fee_event_type_id"], name: "pat_maintenance_fee_events_fkey_pat_maint_fee_event_type_id"
  end

  create_table "pat_normalized_family_relationships", id: :serial, force: :cascade do |t|
    t.string "patnum", limit: 255
    t.bigint "docdb_pat_id"
    t.integer "core_pat_id"
    t.integer "invention_id"
    t.boolean "pat_is_current"
    t.string "related_patnum", limit: 255
    t.integer "related_docdb_pat_id"
    t.integer "related_core_pat_id"
    t.integer "related_invention_id"
    t.boolean "related_pat_is_current"
    t.text "relationship_type"
    t.integer "pat_family_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.index ["core_pat_id"], name: "idx_pat_normalized_family_relationships_core_pat_id"
    t.index ["docdb_pat_id", "related_docdb_pat_id", "relationship_type"], name: "idx_pat_normalized_family_relationships_uniq", unique: true
    t.index ["invention_id"], name: "idx_pat_normalized_family_relationships_invention_id"
    t.index ["pat_family_id"], name: "idx_pat_normalized_family_relationships_family_id"
    t.index ["related_core_pat_id"], name: "idx_pat_normalized_family_relationships_related_core_pat_id"
  end

  create_table "pat_orig_app_num_country", id: :serial, force: :cascade do |t|
    t.integer "pat_id", null: false
    t.string "parent_link_type", limit: 255, null: false
    t.string "parent_app_num_country", limit: 255, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pat_id"], name: "idx_pat_orig_app_num_country_pat_id"
  end

  create_table "pat_other_references", id: :serial, force: :cascade, comment: "Other materials such as scholarly papers this pat refferences as prior art\ntds:orfs" do |t|
    t.integer "pat_id", null: false
    t.text "other_reference", comment: "tds:oref\nOther Reference"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["pat_id"], name: "pat_other_references_fkey_pat_id"
  end

  create_table "pat_primary_conveyance_types", id: :serial, force: :cascade do |t|
    t.text "primary_conveyance_text"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.boolean "is_default", default: false
    t.index ["primary_conveyance_text"], name: "unq_primary_conveyance_text", unique: true
  end

  create_table "pat_priority_claims", id: :serial, force: :cascade do |t|
    t.integer "pat_id", null: false
    t.string "priority_patnum", limit: 255, null: false
    t.date "priority_app_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pat_id"], name: "idx_pat_priority_claims_pat_id"
  end

  create_table "pat_references", id: :serial, force: :cascade, comment: "Patents this pat refferences as prior art.\ntds:refs" do |t|
    t.integer "pat_id", null: false
    t.date "pub_date", comment: "tds:issd\nPublication date of reference"
    t.string "ref_patnum", limit: 18, comment: "tds:ref_patnum\nUS + patent number + kind code of reference"
    t.text "title", comment: "tds:titl\nTitle of reference"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "ref_pat_id"
    t.index ["pat_id", "ref_pat_id"], name: "pat_references_pat_ref_uniq", unique: true
    t.index ["ref_pat_id", "pat_id"], name: "idx_pat_references_ref_pat_uniq", unique: true
    t.index ["ref_patnum", "pat_id"], name: "idx_pat_references__ref_patnum_pat"
  end

  create_table "pat_references_deleted", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "pat_id"
    t.date "pub_date"
    t.string "ref_patnum", limit: 18
    t.text "title"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "ref_pat_id"
    t.datetime "deleted_at"
  end

  create_table "pat_references_staging", id: false, force: :cascade do |t|
    t.text "patnum"
    t.text "issd"
    t.text "ref_patnum"
    t.text "titl"
  end

  create_table "pat_reissue_number", primary_key: "pat_id", id: :integer, comment: "pat_id points to core.pats.id", default: nil, force: :cascade, comment: "Table with latest reissue number for a pat_id" do |t|
    t.string "reissue_number", comment: "reissue patent number"
    t.string "reissue_stripped_patnum", limit: 32, comment: "reissue stripped_patnum"
  end

  create_table "pat_related_documents", id: :serial, force: :cascade, comment: "tds:rupd" do |t|
    t.text "rupt"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "pat_id", null: false
    t.index ["pat_id"], name: "fki_pats_rupd_fk"
  end

  create_table "pat_secondary_conveyance", id: :serial, force: :cascade do |t|
    t.integer "pat_assignment_id", null: false
    t.integer "secondary_conveyance_logic_version", null: false
    t.integer "pat_secondary_conveyance_type_id", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["pat_assignment_id"], name: "pat_secondary_conveyance_ix1"
  end

  create_table "pat_secondary_conveyance_types", id: :serial, force: :cascade do |t|
    t.text "secondary_conveyance_text"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.boolean "is_default", default: false
    t.index ["secondary_conveyance_text"], name: "unq_secondary_conveyance_text", unique: true
  end

  create_table "pat_stats", id: :serial, force: :cascade, comment: "Table to capture stataistics and metrics calculated in-house at RPX." do |t|
    t.string "stripped_patnum", limit: 32, null: false, comment: "The core patent number piece without country or kind code."
    t.string "doc_kind_code", limit: 16, comment: "The patent number kind code."
    t.string "country_code", limit: 16, comment: "The country from the patnum."
    t.string "patnum", limit: 255, comment: "The full patent document number."
    t.integer "num_backward_ref", comment: "The number of patents that this patent references."
    t.integer "num_forward_ref", comment: "The number of patents that reference this patent."
    t.integer "num_claims_independant", comment: "The number of claims in this patent that are not dependant on another claim."
    t.integer "num_claims_dependant", comment: "The number of claims in this patent that do depend on another claim."
    t.boolean "assignment_chain_break", comment: "This is TRUE if the assignees of an assignment (or any of those before) do not match the assignors of the next assignment."
    t.date "priority_date", comment: "This earliest filing date of the extended (US and international) patent family."
    t.boolean "is_continuation", comment: "TRUE if is marked as a continuation in the DocDB dataset."
    t.integer "num_open_continuances", comment: "The number of documents linked as continuances in DocDB."
    t.integer "time_in_review", comment: "The number of days between the application and the issue date of a patent."
    t.integer "word_cnt_indep_claims", comment: "The number of words in all the independant claims combined."
    t.integer "word_cnt_dep_claims", comment: "The number of words in all the dependant claims combined."
    t.integer "word_cnt_patent", comment: "The number of words in the patent. This includes the title, abstract, description, and all claims."
    t.integer "num_npl_ref", comment: "The number of non-patent literature references for the patent."
    t.integer "num_ents_citing", comment: "The number ultimate parent entities (or if not disambiguated, the number of distinct core_names) that have a patent that references this patent."
    t.integer "num_ult_parents_transacted", comment: "The number ultimate parent entities (or if not disambiguated, the number of distinct core_names) that have been referenced in an assignment for this patent."
    t.integer "num_family_members", comment: "The number of patents that share the same patent family."
    t.date "year_4_pay_date", comment: "The date the 4 year maintenance should be paid. This does not indicate it was paid, just the date it should be paid by."
    t.date "year_8_pay_date", comment: "The date the 8 year maintenance should be paid. This does not indicate it was paid, just the date it should be paid by."
    t.date "year_12_pay_date", comment: "The date the 12 year maintenance should be paid. This does not indicate it was paid, just the date it should be paid by."
    t.boolean "is_assign_pre_issue", comment: "TRUE if the first assignment of this patent was recorded before the patent was issued."
    t.datetime "last_updated_by_tds_etl"
    t.datetime "last_updated_by_docdb_etl"
    t.datetime "last_updated_by_assign_etl"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "last_updated_by_family_etl"
    t.integer "run_id"
    t.date "expiration_date"
    t.boolean "is_rpx_owned"
    t.boolean "is_rpx_member_owned"
    t.boolean "is_litigated", default: false
    t.integer "pat_id"
    t.decimal "examination_thoroughness"
    t.integer "num_citing_clusters"
    t.integer "num_citing_assignees"
    t.integer "num_defendants", comment: "number of ultimate parent defendants of a patent where the curated cause type is patent infringement, willful patent infringement"
    t.integer "word_cnt_shortest_indep_claim"
    t.integer "forward_self_cites", array: true
    t.integer "backward_self_cites", array: true
    t.index ["pat_id"], name: "pat_stats_pat_id_idx"
    t.index ["patnum"], name: "pat_stats_patnum_idx"
    t.index ["stripped_patnum", "country_code"], name: "pat_stats_stripped_patnum_country_code_idx", unique: true
    t.index ["stripped_patnum", "doc_kind_code", "country_code"], name: "pat_stats__patnum_kind_country_uniq_idx", unique: true
  end

  create_table "pat_stats_all_assignees", id: :serial, force: :cascade do |t|
    t.integer "pat_id"
    t.integer "alias_id"
    t.integer "run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 255
    t.string "updated_by", limit: 255
    t.index ["alias_id", "pat_id"], name: "idx_pat_stats_all_assignees_alias_pat"
    t.index ["pat_id", "alias_id"], name: "pat_stats_all_assignees_pat_id_alias_id_idx", unique: true
    t.index ["pat_id"], name: "pat_stats_all_assignees_pat_id_idx"
  end

  create_table "pat_stats_continuances", id: :serial, force: :cascade, comment: "A list of documents that this patent is a continuance of, compiled from DocDB." do |t|
    t.integer "pat_stats_id"
    t.string "cont_stripped_patnum", limit: 255, comment: "The stripped patent number for the document that the patent is a continuance of."
    t.string "cont_kind_code", limit: 255, comment: "The kind code for the document that the patent is a continuance of."
    t.string "cont_country_code", limit: 255, comment: "The country for the document that the patent is a continuance of."
    t.string "app_num_intl", limit: 255, comment: "The application country listed for the document that the patent is a continuation of."
    t.string "app_num_country", limit: 255
    t.string "priority_linkage_type", limit: 255, comment: "The DocDB linkage type for the continuance."
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "pat_stats_current_assignees", id: :serial, force: :cascade, comment: "A list of the alias ids that are the current assignees for this patent." do |t|
    t.integer "pat_stats_id", null: false
    t.integer "alias_id", null: false
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "run_id"
    t.integer "pat_id"
    t.index ["alias_id", "pat_id"], name: "idx_pat_stats_current_assignees_alias_pat"
    t.index ["pat_id"], name: "pat_stats_current_assignees_pat_id_idx"
    t.index ["pat_stats_id", "alias_id"], name: "idx_uniq_current_assignees", unique: true
    t.index ["pat_stats_id"], name: "pat_stats_current_assignees__pat_stats_id_idx"
  end

  create_table "pat_stats_current_assignees_dups_ds_3454", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "pat_stats_id"
    t.integer "alias_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "run_id"
  end

  create_table "pat_stats_current_assignors", id: :serial, force: :cascade do |t|
    t.bigint "pat_id"
    t.bigint "pat_stats_id"
    t.bigint "assignment_id"
    t.bigint "alias_id"
    t.date "execution_date"
    t.date "created_at", default: -> { "clock_timestamp()" }
    t.date "updated_at", default: -> { "clock_timestamp()" }
    t.string "created_by"
    t.string "updated_by"
    t.index ["pat_id"], name: "idx_pat_stats_current_assignors_pat_id"
    t.index ["pat_stats_id"], name: "idx_pat_stats_current_assignors_pat_stats_id"
  end

  create_table "pat_stats_dups_ds_3454", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "stripped_patnum", limit: 32
    t.string "doc_kind_code", limit: 16
    t.string "country_code", limit: 16
    t.string "patnum", limit: 255
    t.integer "num_backward_ref"
    t.integer "num_forward_ref"
    t.integer "num_claims_independant"
    t.integer "num_claims_dependant"
    t.boolean "assignment_chain_break"
    t.date "priority_date"
    t.boolean "is_continuation"
    t.integer "num_open_continuances"
    t.integer "time_in_review"
    t.integer "word_cnt_indep_claims"
    t.integer "word_cnt_dep_claims"
    t.integer "word_cnt_patent"
    t.integer "num_npl_ref"
    t.integer "num_ents_citing"
    t.integer "num_ult_parents_transacted"
    t.integer "num_family_members"
    t.date "year_4_pay_date"
    t.date "year_8_pay_date"
    t.date "year_12_pay_date"
    t.boolean "is_assign_pre_issue"
    t.datetime "last_updated_by_tds_etl"
    t.datetime "last_updated_by_docdb_etl"
    t.datetime "last_updated_by_assign_etl"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.datetime "last_updated_by_family_etl"
    t.integer "run_id"
    t.date "expiration_date"
    t.boolean "is_rpx_owned"
    t.boolean "is_rpx_member_owned"
    t.boolean "is_litigated"
  end

  create_table "pat_stats_inventors", id: :serial, force: :cascade do |t|
    t.integer "pat_id"
    t.integer "alias_id"
    t.integer "run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 255
    t.string "updated_by", limit: 255
    t.index ["alias_id"], name: "pat_stats_inventors_alias_id_idx"
    t.index ["pat_id", "alias_id"], name: "pat_stats_inventors_pat_id_alias_id_idx", unique: true
    t.index ["pat_id"], name: "pat_stats_inventors_pat_id_idx"
  end

  create_table "pat_stats_sponsoring_parties", id: :serial, force: :cascade, comment: "A list of the alias ids of the sponsoring party for the patent (patent developer)." do |t|
    t.integer "pat_stats_id", null: false
    t.integer "alias_id", null: false
    t.string "updated_by", limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer "run_id"
    t.integer "pat_id"
    t.index ["alias_id"], name: "idx_pssp_alias_id"
    t.index ["pat_id"], name: "pat_stats_sponsoring_parties_pat_id_idx"
    t.index ["pat_stats_id", "alias_id"], name: "idx_uniq_sponsoring_parties", unique: true
    t.index ["pat_stats_id"], name: "pat_stats_sponsoring_parties__pat_stats_id_idx"
  end

  create_table "patent_analysis_request__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "acquisition_opportunity__c", limit: 18
    t.text "admin_notes__c"
    t.string "analysis_type__c", limit: 255
    t.string "assigned_to__c", limit: 18
    t.datetime "completed_date__c"
    t.datetime "due_date__c"
    t.decimal "hours__c", precision: 5, scale: 1
    t.string "opportunity__c", limit: 18
    t.string "priority__c", limit: 255
    t.decimal "ranking__c", precision: 12, scale: 3
    t.string "request_type__c", limit: 255
    t.text "request__c"
    t.string "requested_by__c", limit: 18
    t.string "sendassignmentnotification__c", limit: 5
    t.string "status__c", limit: 255
    t.text "assigned_to_is_current_user__c"
    t.string "assigned_searcher__c", limit: 18
    t.datetime "vendor_search_due_date__c"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "other_notes__c", limit: 765
    t.text "patents__c"
    t.string "recordtypeid", limit: 18
    t.string "case_key__c", limit: 255
    t.string "case_name__c", limit: 255
    t.decimal "litigation_id__c", precision: 18
    t.string "notes__c", limit: 255
    t.string "status_prior_art_report__c", limit: 255
    t.text "defendants__c"
    t.string "report_name__c", limit: 40
    t.string "account__c", limit: 18
    t.decimal "campaign_id__c", precision: 18
    t.string "campaign_name__c", limit: 255
    t.string "pasp_id__c", limit: 35
    t.string "patent_63", limit: 18
    t.string "patent__c", limit: 18
    t.string "assigned_reviewer__c", limit: 18
    t.index ["id"], name: "upatent_analysis_request__c", unique: true
  end

  create_table "patent_group", id: false, force: :cascade do |t|
    t.string "patent_number", limit: 32
    t.integer "core_pat_id"
    t.string "app_num_country", limit: 2048
  end

  create_table "patent_owners", force: :cascade do |t|
    t.integer "pat_id"
    t.string "stripped_patnum"
    t.string "country_code"
    t.integer "owner_alias_id"
    t.integer "owner_ent_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.index ["pat_id", "owner_alias_id", "start_date", "end_date"], name: "patent_owners_pat_id_owner_alias_id_start_date_end_date_idx", unique: true
    t.index ["pat_id"], name: "patent_owners_pat_id_idx"
    t.index ["stripped_patnum"], name: "idx_patent_owners_stripped_patnum"
  end

  create_table "patents", force: :cascade do |t|
    t.string "patnum"
    t.integer "asset_source"
    t.integer "asset_source_id"
    t.integer "patent_number"
    t.string "country_code"
    t.boolean "matched_with_country_code", default: true
    t.integer "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pats", id: :serial, force: :cascade do |t|
    t.string "patnum", limit: 255, null: false, comment: "US + patent number + kind code"
    t.string "foreign_app_data", limit: 2048, comment: "tds:fapp\nForeign Application Data. From applications, not patents. Use FADL for document listings"
    t.string "doc_kind_code", limit: 2048, comment: "tds:pkcd\nDocument Kind Code – Optional on some document types, required on others, but allowed on all."
    t.string "title", limit: 2048, null: false, comment: "tds:titl\nPatent Title – ENGLISH"
    t.string "int_cross_ref_class", limit: 2048, comment: "tds:crci\nInternational cross ref class. 0 or more entries in file. One entry per CRCI line. Same format as CLSI."
    t.string "fapd_doc_listing", limit: 2048, comment: "tds:fadl\nDocument Listing for FAPD. Text date, or yyyymmdd, then [2 letter country code]"
    t.string "related_app", limit: 2048, comment: "tds:rela\n“Related Application:” In US documents this data is often in the descriptive text and will not appear in this section.  AppNum, Date, relationship (CON, CIP, Parent, etc) may be listed on a single line entry."
    t.string "us_class_at_publication", limit: 2048, comment: "tds:uscp\nU.S. Class at Publication: US Applications and Grants Classification at Publication time."
    t.date "app_filing_date", comment: "tds:apdt\nAppl. filing date - format YYYYMMDD\" - always follows APNS, or APNO."
    t.string "reissue_data_section_label", limit: 2048, comment: "tds:reis\nReissue Data Section Label"
    t.string "foreign_app_priority_data", limit: 2048, comment: "tds:fapd\nFor US:Foreign Application Priority Data For WO/EPPriority Data. Label that Heralds FADL entries"
    t.string "pct_num", limit: 2048, comment: "tds:pcno\nPCT No."
    t.string "pct_pub_num", limit: 2048, comment: "tds:ppnm\nPCT Pub number"
    t.string "ipc_cross_ref_class", limit: 2048, comment: "tds:ccri\nIPC Cross Ref classes. Same format as CCSI"
    t.string "field_of_search", limit: 4096, comment: "tds:foss\nField of Search: Only in EPB is electronic A3 available (scanned search reports cant be used). Field of Search - 1st class/subclass entry - omit prior to first FOS entry"
    t.date "pct_pub_date", comment: "tds:ppdt\nPCT PUB. Date: PCT Filing Date"
    t.string "cross_ref_at_publication", limit: 2048, comment: "tds:uccp\nCross Ref. Classes at document publication time. One UCCP entry for each cross reference classifications assigned (e.g., 1 per line). 0 or more entries."
    t.string "us_class_current", limit: 2048, comment: "tds:clsu\nCurrent U.S. Class: US Class/Subclass"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.date "amended_claims_pub_date", comment: "tds:damc\nDate of Publication of Amended Claims: This applies to the current document (which has the amendments)"
    t.string "app_num_country", limit: 2048, comment: "tds:apnc\nApplication number (country specific)"
    t.string "app_num_intl", limit: 2048, comment: "tds:apni\nApplication number (international style)"
    t.string "intl_class", limit: 2048, comment: "tds:clsi\n”Intern'l Class: “Int. Cl.”  “International Class:” See: Notes on US and International Class formats at the end of this table.  (a.k.a. “IPC”). A single line of data with 2 to 4 items."
    t.string "intl_class_current", limit: 2048, comment: "tds:ccsi\nCurrent Intern'l Class. See: Notes on US and International Class formats at the end of this table. Optionally generated from database. Date of classification (or reclassification) may also be stored on line after the class in parenthesis: B41J 002/175 (YYYYMMDD)"
    t.string "intl_class_edition", limit: 2048, comment: "tds:cice\n“International Class Edition” This is an optional field and is not included on all documents. See: Notes on US and International Class formats at the end of this table.  This is an optional single digit (usually 4 through 8) that indicates what edition of the international specification the class information was produced under."
    t.date "issue_date", comment: "tds:issd\n“Date of Patent:” (USB) “Date of Publication and mention of the grant of patent:” (EPB) Date the patent grant was issued by the patent authority."
    t.date "pct_102_date", comment: "tds:p102\nPCT 102(e) Date"
    t.date "pct_371_date", comment: "tds:p371\nPCT 371 Date"
    t.date "pct_filed_date", comment: "tds:pcfd\nPCT Filed: Filed Date"
    t.date "publication_date"
    t.string "publication_number", limit: 255, comment: "publication number"
    t.string "lastmod", limit: 14, comment: "last modified timestamp from TDS in YYYYMMDDhhmmss GMT."
    t.integer "term_extension", default: 0
    t.string "term_disclaimer", limit: 255
    t.string "salesforce_id", limit: 18
    t.string "stripped_patnum", limit: 32, comment: "This column contains the central piece of the patnum column, with the two digit country prefix and the kind code suffix stripped off."
    t.string "country_code", limit: 16, comment: "This column contains the two digit country code prefix from the patnum column."
    t.boolean "is_application", default: true, null: false, comment: "This column determines whether the record represents an application or a finalized patent. If true the record is for an application, if false the record is an approved patent."
    t.date "earliest_filing_date"
    t.date "term_expiratoin_date"
    t.integer "last_submission_pat_id", default: -1, null: false
    t.integer "next_submission_pat_id"
    t.string "orig_app_num_country", limit: 32, default: "undefined", null: false
    t.boolean "is_dcl_corrected"
    t.string "formal_number", limit: 32
    t.boolean "is_digital_record", default: true
    t.index "app_num_country gin_trgm_ops", name: "pats_app_num_country_idx", using: :gin
    t.index "title gin_trgm_ops", name: "idx_pats_title_gin", using: :gin
    t.index ["app_num_country"], name: "pats__app_num_country_idx"
    t.index ["created_at"], name: "pats__created_at_idx"
    t.index ["intl_class"], name: "idx_pats_intl_class"
    t.index ["is_application"], name: "pats__is_application_idx"
    t.index ["last_submission_pat_id"], name: "idx_pats_last_submission_pat_id1"
    t.index ["next_submission_pat_id"], name: "idx_pats_next_submission_pat_id1"
    t.index ["orig_app_num_country"], name: "idx_pats_orig_app_num_country"
    t.index ["patnum"], name: "pats__patnum_unique_idx", unique: true
    t.index ["salesforce_id"], name: "pats__salesforce_id_idx"
    t.index ["stripped_patnum", "country_code"], name: "pats_stripped_patnum_country_code_idx"
    t.index ["stripped_patnum", "doc_kind_code"], name: "pats__stripped_patnum_doc_kind_code_unique_idx", unique: true
    t.index ["updated_at"], name: "pats__updated_at_idx"
  end

  create_table "pats_aliases_map", id: :serial, force: :cascade do |t|
    t.integer "pat_id", null: false
    t.integer "alias_id", null: false
    t.integer "pats_aliases_relationship_type_id", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "alias_contact_id"
    t.boolean "is_verified", default: false, null: false, comment: "has the alias->pat mapping been approved by a human?"
    t.string "verified_by", limit: 255
    t.text "notes"
    t.index ["alias_contact_id"], name: "idx_pats_aliases_map_contact_id"
    t.index ["alias_id"], name: "pats_aliases_map_fkey_alias_id"
    t.index ["pat_id", "alias_id", "pats_aliases_relationship_type_id"], name: "pats_aliases_map__pat_id_alias_id_pats_aliases_relationship_typ", unique: true
    t.index ["pat_id"], name: "pats_aliases_map_fkey_pat_id"
  end

  create_table "pats_aliases_relationship_types", id: :serial, force: :cascade, comment: "inventor, examinor, assistant examinor, lawyer, ..." do |t|
    t.string "name", limit: 255, null: false, comment: "rpx=# select count(id), party_type, app_type from parties group by 2,3 order by 1 desc;\n  count  |     party_type     |      app_type      \n---------+--------------------+--------------------\n 3234036 | applicant          | applicant-inventor\n 2090607 | agent              | \n 1706880 | assignee           | \n 1297892 | primary_examiner   | \n 1282899 | inventor           | \n  542185 | primary-examiner   | \n  505915 | assistant_examiner | \n  231045 | assistant-examiner | \n    3071 | applicant          | applicant"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "is_default", default: false, null: false, comment: "When TRUE, the value is the one that should be used for any new record where the value is not known. There should only be one TRUE record in the table."
  end

  create_table "pats_assignments_map", id: :serial, force: :cascade, comment: "This table maps patents to assignment records in the pat_assignments table. This table has one record per patent.  Comment updated at: 2012-11-06" do |t|
    t.string "patnum", limit: 255, null: false, comment: "Maps to core.pats.patnum and all other patnum fields except core.lits_pats_map.patnum. Comment updated at: 2012-11-06"
    t.string "stripped_patnum", limit: 255, null: false, comment: "Maps to all other stripped_patnum fields as well as core.lits_pats_map.patnum. Comment updated at: 2012-11-06"
    t.string "doc_kind_code", limit: 16
    t.integer "pat_assignment_id", null: false
    t.boolean "is_zero_assignment", default: false, comment: "If true, the assignment is considered \"name on face of patent\". These are fake assignments created to allow us to easily store the name on the face of patent when it was issued. These are not recorded assignments with USPTO. Comment updated at: 2012-11-06"
    t.integer "document_type_id"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.string "country_code", limit: 16
    t.integer "pat_id", comment: "Patent ID from core.pats. Comment updated at: 2016-05-20"
    t.integer "invention_id", comment: "Invention ID from core.pats_invention. Comment updated at: 2016-05-20"
    t.index ["invention_id"], name: "pats_assignments_map__invention_id_idx"
    t.index ["pat_assignment_id", "pat_id"], name: "idx_pats_assignments_map_assingment_pat_id"
    t.index ["pat_id"], name: "pats_assignments_map__pat_id_idx"
    t.index ["patnum"], name: "pats_assignments_map__patnum_idx"
    t.index ["stripped_patnum"], name: "pats_assignments_map__stripped_patnum_idx"
  end

  create_table "pats_field_of_search", id: :serial, force: :cascade do |t|
    t.integer "pat_id", null: false, comment: "This column references to the patents from core.pats table."
    t.string "stripped_patnum", limit: 32, comment: "This column contains the central piece of the patnum column, with the two digit country prefix and the kind code suffix stripped off."
    t.string "field_of_search", limit: 1024, comment: "tds:foss\nField of Search: Only in EPB is electronic A3 available (scanned search reports cant be used). Field of Search - 1st class/subclass entry - omit prior to first FOS entry"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["created_at"], name: "pats_field_of_search_created_at_idx"
    t.index ["updated_at"], name: "pats_field_of_search_updated_at_idx"
  end

  create_table "pats_invention", id: :serial, force: :cascade do |t|
    t.string "app_num_country", limit: 30, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["app_num_country"], name: "idx_pats_invention_app_num_country", unique: true
  end

  create_table "pats_invention_link", id: :serial, force: :cascade do |t|
    t.integer "invention_id", null: false
    t.integer "pat_id", null: false
    t.boolean "is_original", null: false
    t.boolean "is_current", null: false
    t.integer "rnk", null: false
    t.string "document_type", limit: 30, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.string "stripped_patnum", limit: 32
    t.string "current_stripped_patnum", limit: 32
    t.integer "current_pat_id"
    t.index ["invention_id"], name: "idx_pats_invention_link_invention_id"
    t.index ["invention_id"], name: "idx_pats_invention_link_pat_inv_current", where: "(is_current = true)"
    t.index ["pat_id"], name: "idx_pats_invention_link_pat_id", unique: true
  end

  create_table "pats_withdrawn", id: :serial, force: :cascade do |t|
    t.string "stripped_patnum", limit: 32, null: false
    t.index ["stripped_patnum"], name: "idx_pats_withdrawn_stripped_patnum", unique: true
  end

  create_table "payment_data__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "lastactivitydate"
    t.string "account__c", limit: 18
    t.string "row_labels__c", limit: 30
    t.string "id__c", limit: 24
    t.text "rid__c"
    t.string "service__c", limit: 120
    t.datetime "service_start_date__c"
    t.datetime "service_end_date__c"
    t.string "notes__c", limit: 765
    t.string "invoice_number__c", limit: 30
    t.decimal "discount_percent__c", precision: 5, scale: 2
    t.decimal "cpi_percent__c", precision: 5, scale: 2
    t.decimal "amlf_unadjusted__c", precision: 15, scale: 6
    t.decimal "cpi_adjustment__c", precision: 12, scale: 6
    t.decimal "discount__c", precision: 14, scale: 6
    t.decimal "back_fee__c", precision: 14, scale: 6
    t.decimal "license_fee__c", precision: 15, scale: 6
    t.decimal "other_credits__c", precision: 14, scale: 6
    t.decimal "patent_sale__c", precision: 15, scale: 6
    t.decimal "insurance_premium__c", precision: 14, scale: 6
    t.decimal "investment_in_rrgh__c", precision: 14, scale: 6
    t.decimal "loans_repayments__c", precision: 15, scale: 6
    t.decimal "invoice_amount__c", precision: 15, scale: 6
    t.text "account_owner__c"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.decimal "surplus_tax__c", precision: 24, scale: 6
    t.decimal "broker_fee__c", precision: 24, scale: 6
    t.datetime "payment_date_new__c"
    t.string "contract__c", limit: 18
    t.decimal "amount_paid_to_date__c", precision: 11, scale: 2
    t.boolean "manual_update__c"
    t.index ["id"], name: "upayment_data__c", unique: true
  end

  create_table "payment_data__c_ds4213", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate", precision: 6
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate", precision: 6
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp", precision: 6
    t.datetime "lastactivitydate", precision: 6
    t.string "account__c", limit: 18
    t.string "row_labels__c", limit: 30
    t.string "id__c", limit: 24
    t.text "rid__c"
    t.string "service__c", limit: 120
    t.datetime "service_start_date__c", precision: 6
    t.datetime "service_end_date__c", precision: 6
    t.string "notes__c", limit: 765
    t.string "invoice_number__c", limit: 30
    t.decimal "discount_percent__c", precision: 4, scale: 1
    t.decimal "cpi_percent__c", precision: 4, scale: 1
    t.decimal "amlf_unadjusted__c", precision: 15, scale: 6
    t.decimal "cpi_adjustment__c", precision: 12, scale: 6
    t.decimal "discount__c", precision: 14, scale: 6
    t.decimal "back_fee__c", precision: 14, scale: 6
    t.decimal "license_fee__c", precision: 15, scale: 6
    t.decimal "other_credits__c", precision: 14, scale: 6
    t.decimal "patent_sale__c", precision: 15, scale: 6
    t.decimal "insurance_premium__c", precision: 14, scale: 6
    t.decimal "investment_in_rrgh__c", precision: 14, scale: 6
    t.string "paid__c", limit: 5
    t.string "invoiced__c", limit: 255
    t.decimal "loans_repayments__c", precision: 15, scale: 6
    t.decimal "invoice_amount__c", precision: 15, scale: 6
    t.string "payment_date__c", limit: 60
    t.text "account_owner__c"
    t.datetime "lastvieweddate", precision: 6
    t.datetime "lastreferenceddate", precision: 6
    t.decimal "surplus_tax__c", precision: 24, scale: 6
    t.decimal "broker_fee__c", precision: 24, scale: 6
    t.datetime "payment_date_new__c", precision: 6
    t.string "contract__c", limit: 18
    t.index ["id"], name: "payment_data__c_copy_id_key", unique: true
  end

  create_table "portfolio_account__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 80
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "included__c", limit: 255
    t.string "opportunity__c", limit: 18
    t.string "risk_profile_grouping__c", limit: 255
    t.string "solution_account__c", limit: 18
    t.index ["id"], name: "uportfolio_account__c", unique: true
  end

  create_table "portfolios", id: :serial, force: :cascade do |t|
    t.integer "acquisition_id", null: false
    t.string "portfolio_name", null: false
    t.string "notes", null: false
    t.string "is_detected", null: false
    t.string "is_eou_detected", null: false
    t.string "is_claim_charted", null: false
    t.string "is_credible_seller", null: false
    t.datetime "published_at"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.integer "primary_market_sector_type_id"
    t.text "patent_subject_matter"
    t.text "related_products_services"
    t.index ["portfolio_name"], name: "portfolios_portfolio_name_idx"
  end

  create_table "portfolios_ds_3109", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "acquisition_id"
    t.string "portfolio_name"
    t.string "notes"
    t.string "is_detected"
    t.string "acquisition_sf_id"
    t.string "is_eou_detected"
    t.string "is_claim_charted"
    t.string "is_credible_seller"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "product_or_service__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "ownerid", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.text "description__c"
    t.text "linksinfo__c"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "revenue_source__c", limit: 765
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.index ["id"], name: "uproduct_or_service__c", unique: true
  end

  create_table "ptab_annotations", id: :serial, force: :cascade, comment: " This table contains data which is extracted from ptab.find_ptab_case_type() " do |t|
    t.integer "ptab_case_id", null: false
    t.integer "case_type_id", null: false
    t.string "created_by", limit: 255, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "updated_by", limit: 255, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "ptab_attorney", id: :serial, force: :cascade do |t|
    t.integer "petition_id"
    t.bigint "ptab_petition_party_id"
    t.text "attorney_name"
    t.integer "attorney_alias_id"
    t.text "lawfirm_name"
    t.integer "lawfirm_alias_id"
    t.integer "lawfirm_alias_contact_id"
    t.bigint "ptab_case_id"
    t.bigint "ptab_party_id"
    t.text "created_by", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.text "updated_by", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "ptab_case_detail_party_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 50, null: false, comment: "Filing Party value from ptab website in documents page"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "updated_by", limit: 15, null: false
    t.boolean "is_default"
    t.index ["name"], name: "ptab_case_detail_type_unique_name", unique: true
  end

  create_table "ptab_case_details", id: :serial, force: :cascade do |t|
    t.integer "ptab_case_id", null: false
    t.integer "ptab_case_detail_party_type_id", null: false
    t.string "doc_name", limit: 500, null: false
    t.string "doc_type", limit: 100
    t.integer "exhibit_num", null: false
    t.date "filing_date", null: false
    t.string "availability", limit: 50, null: false
    t.string "document_path", limit: 300, comment: "Path of the document in Amazon S3 is stored in this field."
    t.string "attachment_handle", limit: 100
    t.string "attachment_url", limit: 500
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "updated_by", limit: 15, null: false
    t.boolean "is_dcl_corrected", default: false
    t.string "attachment_type", limit: 100
    t.date "missing_from_source_date", comment: "Date when we finalized (after confirming after multiple crawls) that this record is no longer in the site"
    t.string "attachment_name", limit: 500
    t.text "ocr_text"
    t.datetime "ocr_completed_at"
    t.boolean "needs_ocr", default: false
    t.text "ocr_exception"
    t.string "ocr_text_s3_path", limit: 255
    t.integer "ocr_priority", default: 4
    t.index ["attachment_handle"], name: "attachment_handle_unique_idx", unique: true
    t.index ["ptab_case_id"], name: "ptab_case_details_ptab_case_id_idx"
  end

  create_table "ptab_case_relationships", id: :serial, force: :cascade do |t|
    t.integer "lead_case_id", null: false
    t.integer "joined_case_id", null: false
    t.date "join_date", default: -> { "now()" }, null: false
    t.text "created_by", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.text "updated_by", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["lead_case_id", "joined_case_id"], name: "uptab_case_relationships_key", unique: true
  end

  create_table "ptab_case_status_changes", id: :serial, force: :cascade, comment: "Captures history of changes in ptab.status field" do |t|
    t.integer "ptab_case_id", null: false
    t.string "case_status", limit: 64, comment: "old Status value"
    t.datetime "date_entered", default: -> { "clock_timestamp()" }, null: false
    t.datetime "created_at", default: -> { "clock_timestamp()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", default: -> { "clock_timestamp()" }, null: false
    t.string "updated_by", limit: 15, null: false
  end

  create_table "ptab_case_types", id: :serial, force: :cascade do |t|
    t.string "case_type", limit: 4, null: false, comment: "first 3 characters from case number"
    t.string "case_type_desc", limit: 50, null: false, comment: "brief description of the case type"
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.string "updated_by", limit: 15, null: false
    t.boolean "is_default"
  end

  create_table "ptab_cases", id: :serial, force: :cascade do |t|
    t.string "case_num", limit: 20, null: false
    t.date "filing_date", null: false
    t.date "institution_decision_date"
    t.string "stripped_patnum", limit: 10, comment: "Patent Number from the ptab site"
    t.string "country_code", null: false
    t.string "application_num", limit: 10, comment: "application number from the ptab site"
    t.string "status", limit: 64, null: false
    t.string "tech_center", limit: 100, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "updated_by", limit: 15, null: false
    t.integer "ptab_case_type_id"
    t.boolean "is_dcl_corrected", default: false
    t.date "final_decision_date", comment: "Final Written Decision Date"
    t.date "final_outcome_date", comment: "Final Outcome Date"
    t.date "notice_date", comment: "Date of Notice of Accorded Filing Date"
    t.text "reason_for_notice_filing_date", comment: "Source of Notice Date or reason why it is not available"
    t.text "final_decision_outcome"
    t.text "final_outcome"
    t.string "petitioner_application_num", limit: 10
    t.string "petitioner_stripped_patnum", limit: 10
    t.string "petitioner_tech_center", limit: 100
    t.date "missing_from_source_date"
    t.boolean "is_open"
    t.index ["case_num"], name: "idx_ptab_cases_case_num"
    t.index ["created_at"], name: "ptab_cases__created_at_idx"
    t.index ["stripped_patnum", "country_code"], name: "idx_ptab_case_stripped_patnum_country"
    t.index ["updated_at"], name: "ptab_cases__updated_at_idx"
  end

  create_table "ptab_cases_api", id: false, force: :cascade do |t|
    t.integer "ptab_case_id"
    t.string "case_num", limit: 20, null: false
    t.string "inventor_name", limit: 500
    t.string "prosecution_status", limit: 100
    t.date "accorded_filing_date"
    t.index ["case_num"], name: "ptab_cases_api_case_key_key", unique: true
  end

  create_table "ptab_doc_types", id: :serial, force: :cascade do |t|
    t.string "doc_type", limit: 100, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
  end

  create_table "ptab_etl_properties", id: :serial, force: :cascade do |t|
    t.string "property_name", limit: 50
    t.string "property_datatype", limit: 50
    t.string "property_value", limit: 100
    t.integer "job_id"
    t.datetime "updated_at", precision: 6
  end

  create_table "ptab_expert_info", primary_key: "src_id", id: :bigint, default: nil, force: :cascade, comment: " This table is replica of ldc.lit_docs_ptab_petition_expert_info.even the id column is from source table" do |t|
    t.integer "expert_alias_id"
    t.text "expert_name"
    t.integer "doc_ptab_case_detail_id"
    t.text "expert_document_name"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "updated_by", limit: 15, null: false
    t.serial "id", null: false
    t.integer "ptab_case_id", null: false
  end

  create_table "ptab_judges_map", id: :serial, force: :cascade do |t|
    t.integer "ptab_case_id", null: false
    t.integer "judge_alias_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.text "created_by", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.text "updated_by", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["ptab_case_id", "judge_alias_id"], name: "ptab_judges_map_unique_idx", unique: true
  end

  create_table "ptab_parties", id: :serial, comment: "This column is added as it is required for Audit ETL/process", force: :cascade do |t|
    t.integer "ptab_case_id", null: false
    t.integer "ptab_party_type_id", null: false
    t.integer "alias_id", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "updated_by", limit: 15, null: false
    t.boolean "is_primary", default: false
    t.date "missing_from_source_date"
    t.index ["alias_id", "ptab_party_type_id"], name: "idx_ptab_parties_alias_and_type"
    t.index ["ptab_case_id", "alias_id", "ptab_party_type_id"], name: "ptab_parties_id_unique_idx", unique: true
  end

  create_table "ptab_parties_deleted", id: false, force: :cascade do |t|
    t.integer "ptab_case_id"
    t.integer "ptab_party_type_id"
    t.integer "alias_id"
    t.datetime "created_at"
    t.string "created_by", limit: 15
    t.datetime "updated_at"
    t.string "updated_by", limit: 15
    t.integer "id"
    t.boolean "is_primary"
    t.date "missing_from_source_date"
  end

  create_table "ptab_parties_representations", force: :cascade do |t|
    t.bigint "ptab_parties_id"
    t.bigint "lawfirm_alias_id"
    t.bigint "attorney_alias_id"
    t.bigint "lawfirm_alias_contact_id"
    t.bigint "attorney_alias_contact_id"
    t.date "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "created_by", limit: 18
  end

  create_table "ptab_party_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "created_by", limit: 15, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "updated_by", limit: 15, null: false
    t.boolean "is_default"
    t.index ["name"], name: "name_unique_idx", unique: true
  end

  create_table "queue_app_types", primary_key: "app_id", id: :integer, default: nil, force: :cascade do |t|
    t.text "app_desc"
    t.index ["app_desc"], name: "queue_app_types_app_desc_unq", unique: true
  end

  create_table "queue_msg_types", primary_key: "msg_type_id", id: :integer, default: nil, force: :cascade do |t|
    t.text "msg_type_desc"
  end

  create_table "queue_semaphore", id: false, force: :cascade do |t|
    t.integer "flag", null: false
  end

  create_table "rails_admin_histories", id: :serial, force: :cascade do |t|
    t.text "message"
    t.string "username", limit: 255
    t.integer "item"
    t.string "table", limit: 255
    t.integer "month", limit: 2
    t.bigint "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ravel_judges", id: :serial, force: :cascade do |t|
    t.integer "judge_ent_id"
    t.string "judge_name"
    t.integer "num_of_opinions"
    t.text "ravel_link"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.string "created_by", limit: 255
    t.string "updated_by", limit: 255
  end

  create_table "related_company__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "application__c", limit: 18
    t.string "related_account_user_input__c", limit: 765
    t.string "related_account__c", limit: 18
    t.string "type_of_relation__c", limit: 255
    t.string "type_of_relation_verified__c", limit: 255
    t.index ["id"], name: "urelated_company__c", unique: true
  end

  create_table "restriction_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "rj4sf_error", primary_key: ["object_name", "job_type", "id"], force: :cascade do |t|
    t.string "object_name", limit: 60, null: false
    t.string "job_type", limit: 12, null: false
    t.string "id", limit: 18, null: false
    t.datetime "run_timestamp", null: false
    t.string "error_message", limit: 1000
  end

  create_table "rj_etl_properties", id: false, force: :cascade do |t|
    t.integer "id", default: :serial, null: false
    t.string "property_name", limit: 256
    t.string "property_datatype", limit: 256
    t.string "property_value", limit: 256
    t.datetime "updated_at"
    t.datetime "etl_start"
    t.bigint "run_id"
    t.string "status", limit: 25
  end

  create_table "rj_field", primary_key: ["table_name", "field_name"], force: :cascade do |t|
    t.string "table_name", limit: 30, null: false
    t.string "field_name", limit: 60, null: false
    t.string "column_name", limit: 30, null: false
    t.string "label", limit: 70
    t.text "helptext"
    t.index ["table_name", "column_name"], name: "uk_column_name", unique: true
  end

  create_table "rj_field_bk", id: false, force: :cascade do |t|
    t.string "table_name", limit: 30
    t.string "field_name", limit: 60
    t.string "column_name", limit: 30
    t.string "label", limit: 70
    t.text "helptext"
  end

  create_table "rj_field_bkp", id: false, force: :cascade do |t|
    t.string "table_name", limit: 30
    t.string "field_name", limit: 60
    t.string "column_name", limit: 30
    t.string "label", limit: 70
    t.text "helptext"
  end

  create_table "rj_history", primary_key: ["job_id", "object_name", "job_type"], force: :cascade do |t|
    t.decimal "job_id", null: false
    t.string "object_name", limit: 60, null: false
    t.string "job_type", limit: 12, null: false
    t.datetime "query_start_date", null: false
    t.datetime "query_end_date", null: false
    t.datetime "run_date", null: false
    t.datetime "run_complete_date"
    t.string "run_status", limit: 12, null: false
    t.decimal "records_added_etl"
    t.decimal "records_updated_etl"
    t.decimal "records_deleted_etl"
    t.decimal "records_added_sfdc"
    t.decimal "records_updated_sfdc"
    t.decimal "records_deleted_sfdc"
    t.decimal "errors"
    t.decimal "api_count"
    t.datetime "query_restart_date"
    t.datetime "latestdatecovered"
    t.index ["object_name", "job_type", "query_restart_date"], name: "ix_rj_job_history2"
    t.index ["run_status", "object_name", "job_type"], name: "ix_rj_job_status"
  end

  create_table "rj_object", primary_key: "object_name", id: :string, limit: 60, force: :cascade do |t|
    t.string "table_name", limit: 30, null: false
    t.string "label_name", limit: 255
    t.index ["table_name"], name: "uk_object_table", unique: true
  end

  create_table "rj_object_id_map", id: :string, limit: 4, force: :cascade do |t|
    t.string "object_name", limit: 54
  end

  create_table "rj_object_relationship", id: false, force: :cascade do |t|
    t.string "parent_obj_name", limit: 256, null: false
    t.string "child_obj_name", limit: 256, null: false
    t.string "foreign_key_name", limit: 256, null: false
    t.string "relationship_name", limit: 256
    t.string "isrecursive", limit: 256, null: false
  end

  create_table "rj_outbound_message", id: :string, limit: 18, force: :cascade do |t|
    t.datetime "systemmodstamp", null: false
    t.string "update_flag", limit: 1
    t.string "object_name", limit: 80
  end

  create_table "rj_outbound_message_error", id: false, force: :cascade do |t|
    t.datetime "time", null: false
    t.string "message", limit: 255
  end

  create_table "rj_primary_keys_data", id: false, force: :cascade do |t|
    t.integer "id", default: :serial, null: false
    t.string "table_name", limit: 255
    t.string "primary_key", limit: 255
    t.string "value", limit: 255
    t.datetime "created_at", default: -> { "now()" }
  end

  create_table "rj_reference", id: false, force: :cascade do |t|
    t.string "object_name", limit: 60, null: false
    t.string "field_name", limit: 60, null: false
    t.string "value", limit: 255, null: false
  end

  create_table "rockstar_assets_dump", id: false, force: :cascade do |t|
    t.text "case_number"
    t.text "country"
    t.text "app_num_country_raw"
    t.text "stripped_patnum_raw"
    t.text "status"
    t.date "file_date"
    t.date "issue_date"
    t.date "expiration_date"
    t.text "title"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
  end

  create_table "round_rock_dump", id: false, force: :cascade do |t|
    t.string "aqf_status", limit: 50
    t.string "case_number", limit: 50
    t.string "case_type", limit: 50
    t.string "patent_number", limit: 50
    t.string "publication_number", limit: 50
    t.string "application_number", limit: 50
    t.string "country", limit: 50
    t.text "title"
    t.string "status", limit: 50
    t.string "file_date", limit: 50
    t.string "publication_date", limit: 50
    t.string "issue_date", limit: 50
    t.string "current_assignees", limit: 50
    t.string "expiration_date", limit: 50
    t.string "acquisition_name", limit: 50
    t.string "portfolio_name", limit: 50
    t.string "priority_date", limit: 50
    t.string "cpi_tracking", limit: 50
    t.string "annuity_payment_date", limit: 50
    t.string "terminal_disclaimer", limit: 50
    t.string "rpx_ownership_rights_owned", limit: 50
    t.string "rpx_ownership_rights_cns", limit: 50
    t.string "rpx_ownership_rights_sublicense", limit: 50
    t.string "rpx_ownership_rights_sold", limit: 50
    t.string "asset_source", limit: 1
    t.integer "asset_source_id"
    t.date "file_date_date"
    t.date "publication_date_date"
    t.date "issue_date_date"
    t.date "expiration_date_date"
    t.date "priority_date_date"
    t.date "annuity_payment_date_date"
    t.integer "id"
    t.integer "acquisition_id"
    t.integer "portfolio_id"
    t.string "app_num_country", limit: 2048
  end

  create_table "rpx_cpi_asset_tracking_log", id: :serial, force: :cascade do |t|
    t.integer "log_level_id", null: false
    t.integer "app_id"
    t.string "app_name", limit: 50
    t.integer "run_id"
    t.string "db_user", limit: 50, null: false
    t.string "client_host", limit: 512, default: -> { "COALESCE(((inet_client_addr() || ':'::text) || inet_client_port()), 'LOCAL'::text)" }, null: false
    t.string "search_path", limit: 256, default: -> { "btrim((current_schemas(true))::text, '{}'::text)" }, null: false
    t.text "message", null: false
    t.integer "assets_added"
    t.integer "assets_modified"
    t.integer "assets_deleted"
    t.integer "assets_matched"
    t.integer "assets_not_matched"
    t.integer "total_assets"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
    t.index ["app_id", "run_id"], name: "rpx_cpi_asset_tracking_log__app_id__run_id_idx"
    t.index ["app_name"], name: "rpx_cpi_asset_tracking_log__app_name_idx"
    t.index ["log_level_id", "created_at"], name: "rpx_cpi_asset_tracking_log__log_level_id__created_at_idx"
  end

  create_table "rpx_ownership_rights", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "search_doc_misc", id: false, force: :cascade do |t|
    t.string "value", limit: 255
    t.string "key", limit: 64
  end

  create_table "search_misc", id: false, force: :cascade do |t|
    t.text "Search_Amended_Complaint"
    t.text "Search_Appeal_Outcome"
    t.text "Search_Judgment"
    t.text "Search_Markman"
    t.text "Search_Verdict"
  end

  create_table "selected_batch_generated_option_types", id: :serial, force: :cascade do |t|
    t.integer "option_id", null: false
    t.integer "batch_generated_option_type_id", null: false
    t.string "created_by", limit: 64, null: false
    t.string "updated_by", limit: 64, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "seller_documents", id: :serial, force: :cascade do |t|
    t.string "sf_content_document_id", limit: 18, null: false
    t.string "rpx_s3_bucket", limit: 255
    t.string "rpx_file_path_name", limit: 255
    t.integer "document_status_id"
    t.integer "file_type_id"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
  end

  create_table "sf_to_core_column_mapping", id: false, force: :cascade do |t|
    t.integer "map_id", default: :serial
    t.string "core_table_name", limit: 255
    t.string "core_column_name", limit: 255
    t.string "sf_column_name", limit: 255
    t.string "etl_data_type", limit: 56
    t.string "etl_format", limit: 56
    t.boolean "isactive", default: true
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at"
    t.bigint "id", default: :serial
    t.index "btrim((core_table_name)::text), btrim((core_column_name)::text)", name: "sf_to_core_column_mapping_core_table_name_core_column_name_key", unique: true
  end

  create_table "sf_to_core_control_table", id: false, force: :cascade do |t|
    t.integer "job_control_id", default: :serial, null: false
    t.bigint "job_id"
    t.string "core_table_name", limit: 255
    t.datetime "start_time", default: -> { "clock_timestamp()" }
    t.string "status", limit: 20
    t.datetime "end_time"
  end

  create_table "sf_to_core_table_mapping", id: false, force: :cascade do |t|
    t.integer "map_id", default: :serial
    t.string "core_table_name", limit: 255
    t.string "sf_table_name", limit: 255
    t.boolean "isactive"
    t.string "job_name", limit: 256, default: "sf_incr_load"
    t.boolean "is_full_load", default: false
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at"
    t.bigint "id", default: :serial
    t.index ["core_table_name", "job_name"], name: "sf_to_core_table_mapping_core_table_name_job_name_key", unique: true
  end

  create_table "sf_to_core_trans_metrics", id: false, force: :cascade do |t|
    t.string "step_name", limit: 255
    t.string "step_id", limit: 255
    t.bigint "lines_input"
    t.bigint "lines_output"
    t.bigint "lines_read"
    t.bigint "lines_updated"
    t.bigint "lines_written"
    t.bigint "lines_rejected"
    t.float "duration"
    t.string "core_table_name", limit: 255
    t.bigint "job_id"
    t.string "job_type", limit: 20
    t.integer "trans_metrics_id", default: :serial, null: false
    t.string "load_type"
    t.string "is_del"
  end

  create_table "similar_ents_tmp", id: false, force: :cascade do |t|
    t.integer "ent_id"
    t.string "ent_name"
    t.integer "ent_id_to_delete"
    t.string "ent_name_to_delete"
    t.integer "score"
    t.index ["ent_id"], name: "ents_ent_id_idx"
    t.index ["ent_id_to_delete"], name: "ents_ent_id_to_delete_idx"
    t.index ["ent_name"], name: "ents_ent_name_idx"
    t.index ["ent_name_to_delete"], name: "ents_ent_name_to_delete_idx"
    t.index ["score"], name: "ents_score_tmp"
  end

  create_table "soundview_assets_dump", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "family"
    t.text "patent_number_raw"
    t.text "publication_number_raw"
    t.text "application_number_raw"
    t.text "country"
    t.text "title"
    t.text "application_status"
    t.text "filed_date_actual"
    t.text "publication_date_actual"
    t.text "issue_date_actual"
    t.text "current_assignee"
    t.text "annuity_fee_status"
    t.date "expiration_date"
    t.text "notes"
    t.text "type"
    t.text "upload_status"
    t.string "app_num_country", limit: 2048
    t.string "stripped_patnum", limit: 2048
    t.string "publication_number", limit: 2048
    t.date "filed_date"
    t.date "publication_date"
    t.date "issue_date"
  end

  create_table "stage_cpi_weekly_master", id: :serial, force: :cascade do |t|
    t.text "client"
    t.date "run_date"
    t.string "case_number", limit: 50
    t.string "country_code", limit: 50
    t.string "wipo", limit: 8
    t.string "subcase", limit: 50
    t.string "client_division", limit: 200
    t.string "case_type", limit: 50
    t.string "status", limit: 50
    t.string "application_number", limit: 50
    t.date "filing_date"
    t.string "patent_number", limit: 32
    t.date "issue_date"
    t.string "publication_number", limit: 50
    t.date "publication_date"
    t.date "tax_base_date"
    t.string "working_base_date", limit: 50
    t.string "tax_schedule", limit: 50
    t.string "paid_thru", limit: 50
    t.string "agent", limit: 200
    t.date "expiration_date"
    t.text "attorney_inv"
    t.text "attorney_ctry"
    t.text "client_ref_inv"
    t.text "client_ref_1_ctry"
    t.text "client_ref_2_ctry"
    t.string "priority_number", limit: 50
    t.text "assignee_inv"
    t.text "assignee_ctry"
    t.text "title"
    t.text "inventor_1"
    t.text "inventor_2"
    t.text "inventor_3"
    t.text "inventor_4"
    t.text "remarks"
    t.text "comments"
    t.string "rate", limit: 50
    t.string "wkpd_thru", limit: 50
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 64
    t.string "updated_by", limit: 64
  end

  create_table "task", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "recordtypeid", limit: 18
    t.string "whoid", limit: 18
    t.string "whatid", limit: 18
    t.string "subjectx", limit: 765
    t.datetime "activitydate"
    t.string "statusx", limit: 255
    t.string "priority", limit: 255
    t.string "ownerid", limit: 18
    t.text "description"
    t.string "currencyisocode", limit: 255
    t.string "typex", limit: 255
    t.string "isdeleted", limit: 5
    t.string "accountid", limit: 18
    t.string "isclosed", limit: 5
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "isarchived", limit: 5
    t.string "isvisibleinselfservice", limit: 5
    t.decimal "calldurationinseconds"
    t.string "calltype", limit: 255
    t.string "calldisposition", limit: 765
    t.string "callobject", limit: 765
    t.datetime "reminderdatetime"
    t.string "isreminderset", limit: 5
    t.string "recurrenceactivityid", limit: 18
    t.string "isrecurrence", limit: 5
    t.datetime "recurrencestartdateonly"
    t.datetime "recurrenceenddateonly"
    t.string "recurrencetimezonesidkey", limit: 255
    t.string "recurrencetype", limit: 255
    t.decimal "recurrenceinterval"
    t.decimal "recurrencedayofweekmask"
    t.decimal "recurrencedayofmonth"
    t.string "recurrenceinstance", limit: 255
    t.string "recurrencemonthofyear", limit: 255
    t.string "conference__c", limit: 240
    t.string "conferences__c", limit: 255
    t.string "contact_type__c", limit: 255
    t.string "content_category__c", limit: 255
    t.string "importancehelpfulnessofmeeting", limit: 255
    t.string "quality_of_conversation__c", limit: 255
    t.string "social_event__c", limit: 255
    t.string "social__c", limit: 255
    t.datetime "activity_date__c"
    t.string "area_where_we_can_show_value", limit: 765
    t.text "assigned_analyst__c"
    t.string "cost_of_litigations__c", limit: 765
    t.text "format_of_materials__c"
    t.string "indemnity__c", limit: 765
    t.string "litigations__c", limit: 765
    t.string "main_obstacles_to_closing__c", limit: 765
    t.string "materials_presented__c", limit: 765
    t.string "materials_requested__c", limit: 765
    t.string "meeting_objective_realized_com", limit: 765
    t.string "meeting_objective_realized__c", limit: 5
    t.string "meeting_objective__c", limit: 765
    t.string "meeting_type__c", limit: 255
    t.decimal "meeting__c", precision: 3
    t.string "next_steps__c", limit: 765
    t.string "open_market_opportunities__c", limit: 765
    t.text "prospect_provided_following_in"
    t.string "prospect_sophistication_commen", limit: 765
    t.text "prospect_sophistication__c"
    t.string "prospect_s_main_concerns__c", limit: 765
    t.string "specifics_on_info_provided_by", limit: 765
    t.string "what_worked_didn_t_work__c", limit: 765
    t.string "who_from_prospect__c", limit: 765
    t.string "who_from_rpx__c", limit: 765
    t.string "meeting_complete__c", limit: 5
    t.string "contact_name__c", limit: 765
    t.string "myupdatefield__c", limit: 3
    t.string "contact_title__c", limit: 384
    t.string "result__c", limit: 255
    t.string "outreach_purpose__c", limit: 150
    t.string "talk_track__c", limit: 765
    t.string "recurrenceregeneratedtype", limit: 255
    t.string "link_to_acquisition__c", limit: 765
    t.string "link_to_option_record__c", limit: 765
    t.string "title__c", limit: 240
    t.string "subject_cont_d__c", limit: 255
    t.string "hours_spent__c", limit: 255
    t.string "acquisition__c", limit: 18
    t.index ["id"], name: "utask", unique: true
  end

  create_table "technology_centers", id: :serial, force: :cascade do |t|
    t.string "tech_center_number", limit: 100
    t.text "description"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.string "created_by", limit: 15
    t.string "updated_by", limit: 15
    t.index ["tech_center_number"], name: "technology_centers_tech_center_number_unique_key", unique: true
  end

# Could not dump table "temp_patent_families" because of following StandardError
#   Unknown type 'unknown' for column 'name'

  create_table "tx_sequential_control", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "function_name", limit: 64
    t.text "description"
    t.integer "flag"
  end

  create_table "unicodes", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "unicode_char"
    t.string "rep_char"
  end

  create_table "us_patent_match_result", id: false, force: :cascade do |t|
    t.integer "docdb_pat_id"
    t.string "core_patnum", limit: 32
    t.string "docdb_patnum", limit: 32
    t.integer "core_pat_id"
    t.integer "match_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_patents", id: false, force: :cascade do |t|
    t.string "patnum", limit: 255
    t.integer "id"
    t.string "stripped_patnum", limit: 255
    t.integer "length_of_patnum"
    t.text "patent_code"
  end

  create_table "users", id: :serial, force: :cascade, comment: "This is the user table for the DMA application Comment updated at: 2012-11-06" do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "roles_mask"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "userx", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 1, default: "N", null: false
    t.string "id", limit: 18
    t.string "username", limit: 240
    t.string "lastname", limit: 240
    t.string "firstname", limit: 120
    t.string "namex", limit: 363
    t.string "companyname", limit: 240
    t.string "division", limit: 240
    t.string "department", limit: 240
    t.string "title", limit: 240
    t.string "street", limit: 765
    t.string "city", limit: 120
    t.string "statex", limit: 60
    t.string "postalcode", limit: 60
    t.string "country", limit: 120
    t.string "email", limit: 240
    t.string "phone", limit: 120
    t.string "fax", limit: 120
    t.string "mobilephone", limit: 120
    t.string "aliasx", limit: 24
    t.string "communitynickname", limit: 120
    t.string "isactive", limit: 5
    t.string "timezonesidkey", limit: 255
    t.string "userroleid", limit: 18
    t.string "localesidkey", limit: 255
    t.string "receivesinfoemails", limit: 5
    t.string "receivesadmininfoemails", limit: 5
    t.string "emailencodingkey", limit: 255
    t.string "defaultcurrencyisocode", limit: 255
    t.string "currencyisocode", limit: 255
    t.string "profileid", limit: 18
    t.string "usertype", limit: 255
    t.string "languagelocalekey", limit: 255
    t.string "employeenumber", limit: 60
    t.string "delegatedapproverid", limit: 18
    t.string "managerid", limit: 18
    t.datetime "lastlogindate"
    t.datetime "lastpasswordchangedate"
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.datetime "offlinetrialexpirationdate"
    t.datetime "offlinepdatrialexpirationdate"
    t.string "userpermissionsmarketinguser", limit: 5
    t.string "userpermissionsofflineuser", limit: 5
    t.string "userpermissionsavantgouser", limit: 5
    t.string "userpermissionscallcenterautol", limit: 5
    t.string "userpermissionsmobileuser", limit: 5
    t.string "userpermissionssfcontentuser", limit: 5
    t.string "userpermissionsinteractionuser", limit: 5
    t.string "userpermissionssupportuser", limit: 5
    t.string "userpermissionsjigsawprospecti", limit: 5
    t.string "forecastenabled", limit: 5
    t.string "userpreferencesactivityreminde", limit: 5
    t.string "userpreferenceseventremindersc", limit: 5
    t.string "userpreferencestaskremindersch", limit: 5
    t.string "userpreferencesremindersoundof", limit: 5
    t.string "userpreferencescontentnoemail", limit: 5
    t.string "userpreferencesdisableautosubf", limit: 5
    t.string "userpreferencescontentemailasa", limit: 5
    t.string "userpreferencesapexpagesdevelo", limit: 5
    t.string "contactid", limit: 18
    t.string "accountid", limit: 18
    t.string "callcenterid", limit: 18
    t.string "extension", limit: 120
    t.text "federationidentifier"
    t.text "aboutme"
    t.text "currentstatus"
    t.text "fullphotourl"
    t.text "smallphotourl"
    t.string "digestfrequency", limit: 255
    t.string "defaultgroupnotificationfreque", limit: 255
    t.string "springcm2sf__springcm_user__c", limit: 5
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string "userpreferencesoptoutoftouch", limit: 5
    t.string "userpreferenceshidecsngetchatt", limit: 5
    t.string "userpreferenceshidecsndesktopt", limit: 5
    t.string "auto_follow_acquisition__c", limit: 5
    t.string "auto_follow_opportunity__c", limit: 5
    t.string "userpermissionschatteranswersu", limit: 5
    t.string "userpreferencesdisableallfeeds", limit: 5
    t.string "userpreferencesdisablefollower", limit: 5
    t.string "userpreferencesdisableprofilep", limit: 5
    t.string "userpreferencesdisablechangeco", limit: 5
    t.string "userpreferencesdisablelatercom", limit: 5
    t.string "userpreferencesdisprofpostcomm", limit: 5
    t.string "userpreferencesdisablementions", limit: 5
    t.string "userpreferencesdismentionscomm", limit: 5
    t.string "userpreferencesdiscommentafter", limit: 5
    t.string "userpreferencesdisablelikeemai", limit: 5
    t.string "userpreferencesdisablemessagee", limit: 5
    t.string "userpreferencesdisablebookmark", limit: 5
    t.string "userpreferencesdisablesharepos", limit: 5
    t.string "userpreferencesenableautosubfo", limit: 5
    t.string "userpreferencesdisablefileshar", limit: 5
    t.text "claims__signature"
    t.decimal "latitude", precision: 18, scale: 15
    t.decimal "longitude", precision: 18, scale: 15
    t.string "emailpreferencesautobcc", limit: 5
    t.string "emailpreferencesautobccstayint", limit: 5
    t.string "emailpreferencesstayintouchrem", limit: 5
    t.string "senderemail", limit: 240
    t.string "sendername", limit: 240
    t.text "signature"
    t.string "stayintouchsubject", limit: 240
    t.text "stayintouchsignature"
    t.text "stayintouchnote"
    t.string "isbadged", limit: 5
    t.string "userpreferenceshidechatteronbo", limit: 5
    t.string "userpreferenceshidesecondchatt", limit: 5
    t.string "userpreferencesjigsawlistuser", limit: 5
    t.string "userpreferencesshowtitletoexte", limit: 5
    t.string "userpreferencesshowmanagertoex", limit: 5
    t.string "userpreferencesshowemailtoexte", limit: 5
    t.string "userpreferencesshowworkphoneto", limit: 5
    t.string "userpreferencesshowmobilephone", limit: 5
    t.string "userpreferencesshowfaxtoextern", limit: 5
    t.string "userpreferencesshowstreetaddre", limit: 5
    t.string "userpreferencesshowcitytoexter", limit: 5
    t.string "userpreferencesshowstatetoexte", limit: 5
    t.string "userpreferencesshowpostalcodet", limit: 5
    t.string "userpreferencesshowcountrytoex", limit: 5
    t.string "userpreferencesshowprofilepict", limit: 5
    t.string "userpreferencesshowtitletogues", limit: 5
    t.string "userpreferencesshowcitytoguest", limit: 5
    t.string "userpreferencesshowstatetogues", limit: 5
    t.string "userpreferencesshowpostalcode0", limit: 5
    t.string "userpreferencesshowcountrytogu", limit: 5
    t.string "userpreferenceshides1browserui", limit: 5
    t.string "userpreferencesdisableendorsem", limit: 5
    t.decimal "jigsawimportlimitoverride"
    t.datetime "lastvieweddate"
    t.datetime "lastreferenceddate"
    t.string "portalrole", limit: 255
    t.string "isportalenabled", limit: 5
    t.string "isportalselfregistered", limit: 5
    t.string "autocreated__c", limit: 5
    t.string "community_user_hierarchy__c", limit: 18
    t.string "inviter__c", limit: 765
    t.text "address"
    t.string "userpreferenceslightningexperi", limit: 5
    t.string "userpermissionsknowledgeuser", limit: 5
    t.string "userpreferencessortfeedbycomme", limit: 5
    t.index ["id"], name: "uuserx", unique: true
  end

  create_table "uspcs_classes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 3, null: false
    t.string "description", limit: 1000
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.index ["code"], name: "uidx_uspcs_classes_code", unique: true
  end

  create_table "uspcs_subclasses", id: :serial, force: :cascade do |t|
    t.string "description", limit: 1000
    t.integer "uspcs_class_id"
    t.string "code", limit: 11
    t.string "orig_code", limit: 11
    t.integer "parent_uspcs_subclass_id"
    t.integer "job_id"
    t.datetime "updated_at", default: -> { "now()" }
    t.datetime "created_at", default: -> { "now()" }
    t.index ["code"], name: "uidx_uspcs_subclasses_code", unique: true
    t.index ["created_at"], name: "uspcs_subclasses__created_at_idx"
    t.index ["orig_code"], name: "idx_uspcs_subclasses_orig_code"
    t.index ["updated_at"], name: "uspcs_subclasses__updated_at_idx"
    t.index ["uspcs_class_id"], name: "idx_uspcs_subclasses_uspcs_class_id"
  end

  create_table "uspcs_to_ipc_mapping", id: :serial, force: :cascade do |t|
    t.string "uspcs_subclass", limit: 50
    t.string "ipc_subclass_code", limit: 14
    t.string "ipc_subgroup_code", limit: 14
    t.string "code_type", limit: 5
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
  end

  create_table "uspto_practitioner_roster", id: false, force: :cascade do |t|
    t.integer "id", default: :serial, null: false
    t.integer "alias_id"
    t.string "firm_name", limit: 128
    t.string "role", limit: 8
    t.string "emp_status", limit: 10
    t.string "registration_number", limit: 15
    t.integer "alias_contact_id"
    t.date "missing_from_source_date"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at"
  end

  create_table "v_continue_flag", id: false, force: :cascade do |t|
    t.integer "case"
  end

  create_table "v_relationship_id", id: false, force: :cascade do |t|
    t.integer "id"
  end

  create_table "valuation_tracking__c", primary_key: "etl_id", id: :serial, force: :cascade do |t|
    t.string "delete_flag", limit: 2, default: "N", null: false
    t.string "id", limit: 18
    t.string "isdeleted", limit: 5
    t.string "namex", limit: 240
    t.string "currencyisocode", limit: 255
    t.string "recordtypeid", limit: 18
    t.datetime "createddate"
    t.string "createdbyid", limit: 18
    t.datetime "lastmodifieddate"
    t.string "lastmodifiedbyid", limit: 18
    t.datetime "systemmodstamp"
    t.string "received_from__c", limit: 18
    t.string "contact_source__c", limit: 18
    t.datetime "date_received__c"
    t.string "bidder__c", limit: 18
    t.decimal "valuation_in_000s__c", precision: 14, scale: 6
    t.string "estimate__c", limit: 5
    t.string "bidder_type__c", limit: 255
    t.text "notes__c"
    t.string "acquisition__c", limit: 18
    t.string "type_of_guidance__c", limit: 255
    t.text "recordtypename__c"
    t.datetime "date_time_received__c"
    t.datetime "created_at", default: -> { "now()" }
    t.datetime "updated_at", default: -> { "now()" }
    t.index ["id"], name: "uvaluation_tracking__c", unique: true
  end
  create_table "alias_contacts", primary_key: "id", id: :serial, force: :cascade do |t|
  end

  add_foreign_key "acquisition_agreements", "acquisitions", name: "acquisition_acquisition_agreement_fk"
  add_foreign_key "acquisition_agreements", "agreement_terms", name: "agreement_term_fk"
  add_foreign_key "acquisition_agreements", "all_accounts", column: "seller_sf_account_id", name: "acquisition_agreements_account_id_fk"
  add_foreign_key "acquisition_encumbrance_patents", "acquisition_encumbrances", name: "acquisition_encumbrance_patents_acquisition_encumbrance_id_fkey"
  add_foreign_key "acquisition_encumbrance_patents", "acquisition_patents", name: "acquisition_encumbrance_patents_acquisition_patent_id_fkey"
  add_foreign_key "acquisition_encumbrances", "acquisitions", name: "acquisition_encumbrance_fk"
  add_foreign_key "acquisition_encumbrances", "all_accounts", column: "entity_sf_account_id", name: "acquisition_encumbrances_account_id_fk"
  add_foreign_key "acquisition_encumbrances", "encumbrance_types", name: "encrumbance_type_fk"
  add_foreign_key "acquisition_opportunities_portfolios", "acquisition_opportunity__c", column: "acquisition_sf_id", name: "acquisition_opportunities_portfolios_acquisition_sf_id_fk"
  add_foreign_key "acquisition_opportunities_portfolios", "portfolios", name: "acquisition_opportunities_portfolios_portfolio_id_fk"
  add_foreign_key "acquisition_option_patents", "acquisition_options", name: "acquisition_option_patents_acquisition_option_id_fkey"
  add_foreign_key "acquisition_option_patents", "acquisition_patents", name: "acquisition_option_patents_acquisition_patent_id_fkey"
  add_foreign_key "acquisition_options", "acquisitions", name: "acquisition_option_fk"
  add_foreign_key "acquisition_options", "all_accounts", column: "entity_sf_account_id", name: "acquisition_options_account_id_fk"
  add_foreign_key "acquisition_options", "divestitures", name: "acquisition_options_divestiture_id_fk"
  add_foreign_key "acquisition_options", "option_types", name: "option_type_fk"
  add_foreign_key "acquisition_patent_attributes", "acquisition_patents", name: "acquisition_patent_attributes_acq_pat_id_fkey"
  add_foreign_key "acquisition_patent_attributes", "case_types", name: "acquisition_patent_attributes_case_type_id_fkey"
  add_foreign_key "acquisition_patent_attributes_dcl", "acquisition_patent_attributes", name: "acquisition_pat_attribs_dcl_acq_pat_attr_id_fkey", on_delete: :cascade
  add_foreign_key "acquisition_patent_attributes_dcl", "case_types", name: "acquisition_patent_attributes_dcl_case_type_id_fkey"
  add_foreign_key "acquisition_patents", "acquisitions", name: "acquisition_acquisition_patent_fk"
  add_foreign_key "acquisition_patents", "asset_status_types", name: "acquisition_patents_asset_status_type_fk"
  add_foreign_key "acquisition_patents", "cpi_tracking_status", name: "acquisition_patent_trck_cpi_options_fk"
  add_foreign_key "acquisition_patents", "portfolios", name: "acquisition_patents_portfolio_id_fk"
  add_foreign_key "acquisition_patents_current_assignee_aliases", "acquisition_patents", name: "acquisition_patents_current_assignee_aliases_fk1"
  add_foreign_key "acquisition_patents_current_assignee_aliases", "aliases", name: "acquisition_patents_current_assignee_aliases_fk2"
  add_foreign_key "acquisition_patents_dcl", "acquisition_patents", name: "acquisition_pats_dcl_acq_pat_id_fkey", on_delete: :cascade
  add_foreign_key "acquisition_patents_dcl", "acquisitions", name: "acquisition_patent_dcl_acq_fk"
  add_foreign_key "acquisition_patents_dcl", "asset_status_types", name: "acquisition_patents_dcl_asset_status_fk"
  add_foreign_key "acquisition_patents_dcl", "portfolios", name: "acquisition_patents_portfolio_id_fk"
  add_foreign_key "acquisition_patents_dcl_current_assignee_aliases", "acquisition_patents_dcl", column: "acquisition_patent_dcl_id", name: "acquisition_patents_dcl_current_assignee_aliases_fk1"
  add_foreign_key "acquisition_patents_dcl_current_assignee_aliases", "aliases", name: "acquisition_patents_dcl_current_assignee_aliases_fk2"
  add_foreign_key "acquisition_patents_dcl_rpx_ownership_rights", "rpx_ownership_rights", name: "acquisition_patent_rpx_ownership_right_fk"
  add_foreign_key "acquisition_restriction_patents", "acquisition_patents", name: "acquisition_restriction_patents_acquisition_patent_id_fkey"
  add_foreign_key "acquisition_restriction_patents", "acquisition_restrictions", name: "acquisition_restriction_patents_acquisition_restriction_id_fkey"
  add_foreign_key "acquisition_restrictions", "acquisitions", name: "acquisition_restriction_fk"
  add_foreign_key "acquisition_restrictions", "all_accounts", column: "entity_sf_account_id", name: "acquisition_restrictions_account_id_fk"
  add_foreign_key "acquisition_restrictions", "restriction_types", name: "restriction_type_fk"
  add_foreign_key "acquisition_syndications", "acquisitions", name: "acquisition_syndication_fk"
  add_foreign_key "acquisition_syndications", "all_accounts", column: "entity_sf_account_id", name: "acquisition_syndications_account_id_fk"
  add_foreign_key "acquisitions", "acquisition_types", name: "acquisition_type_fk"
  add_foreign_key "acquisitions", "counter_party_types", name: "acquisitions_counter_party_type_id_fk", on_delete: :nullify
  # add_foreign_key "alias_contacts", "aliases", name: "aliases_alias_addresses_fk"
  add_foreign_key "aliases", "ents", name: "aliases_fkey_ent_id"
  # add_foreign_key "assignees_aliases_map", "alias_contacts", name: "alias_contact_bk_assignees_aliases_map_fk"
  add_foreign_key "assignees_aliases_map", "aliases", name: "aliases_assignees_aliases_map_fk"
  add_foreign_key "assignees_aliases_map", "pat_assignments", column: "assignment_id", name: "assignments_assignees_aliases_map_fk"
  # add_foreign_key "assignors_aliases_map", "alias_contacts", name: "alias_contacts_assignors_aliases_map_fk"
  add_foreign_key "assignors_aliases_map", "aliases", name: "aliases_assignment_alias_map_fk"
  add_foreign_key "assignors_aliases_map", "pat_assignments", column: "assignment_id", name: "assignments_assignment_ent_fk"
  add_foreign_key "batch_generated_option_ents", "acquisition_options", column: "option_id", name: "batch_generated_option_ents_option_id_fk"
  add_foreign_key "batch_generated_option_ents", "all_accounts", column: "account_id", name: "batch_generated_option_ents_account_id_fk"
  add_foreign_key "batch_generated_option_ents", "batch_generated_option_statuses", column: "bgo_status_id", name: "batch_generated_option_ents_bgo_status_id_fk"
  add_foreign_key "batch_generated_option_ents", "batch_generated_option_types", column: "bgo_type_id", name: "batch_generated_option_ents_bgo_type_id_fk"
  add_foreign_key "court_details", "ents", name: "ents_court_detail_fk"
  add_foreign_key "divestiture_patents", "acquisition_patents_dcl", name: "divestiture_patents_acquisition_patents_dcl_id_fk"
  add_foreign_key "divestiture_patents", "divestitures", name: "divestiture_patents_divestiture_id_fk"
  add_foreign_key "divestitures", "accountx", column: "seller_sf_account_id", name: "divestitures_seller_sf_account_id_fk"
  add_foreign_key "divestitures", "counter_party_types", name: "divestitures_counter_party_type_id_fk"
  add_foreign_key "divestitures", "userx", column: "legal_lead_sf_userx_id", name: "divestitures_legal_lead_sf_userx_id_fk"
  add_foreign_key "dma_lit_annotations", "lit_classification_types", name: "dma_annotations_lit_classification_type_id_fk"
  add_foreign_key "dma_lit_annotations", "lit_curated_cause_types", name: "dma_annotations_lit_curated_cause_type_id_fk"
  add_foreign_key "dma_lit_annotations", "lit_types", name: "dma_annotations_lit_type_id_fk"
  add_foreign_key "dma_lit_annotations", "lits", name: "dma_annotations_lit_id_fk"
  add_foreign_key "dma_lit_annotations", "market_sector_types", name: "dma_annotations_market_sector_type_id_fk"
  add_foreign_key "dma_lits_pats_map", "lits", name: "dma_lits_pats_map_lit_id_fk"
  add_foreign_key "docdb_abstracts", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_abstracts_fk"
  add_foreign_key "docdb_applicants", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_applicants_fk"
  add_foreign_key "docdb_citations", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_citations_fk"
  add_foreign_key "docdb_classifications", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_classifications_fk"
  add_foreign_key "docdb_inventors", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_inventors_fk"
  add_foreign_key "docdb_ipcs", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_ipcs_fk"
  add_foreign_key "docdb_logs", "docdb_batch", column: "batch_id", name: "docdb_logs_fk"
  add_foreign_key "docdb_national_classifications", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_national_classifications_fk"
  add_foreign_key "docdb_priority_claims", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_priority_claims_fk"
  add_foreign_key "docdb_titles", "docdb_pats", column: "pat_id", name: "docdb_pats_docdb_titles_fk"
  add_foreign_key "docket_entries", "lits", name: "lits_docket_entries_fk"
  add_foreign_key "docket_entry_documents_map", "docket_entries", name: "docket_entries_docket_entry_documents_fk"
  add_foreign_key "docket_entry_documents_map", "lit_documents", name: "documents_docket_entry_documents_fk"
  add_foreign_key "ent_advanced_relationships", "ent_advanced_relationship_types", name: "ent_advanced_relationship_types_ent_advanced_relationships_fk"
  add_foreign_key "ent_advanced_relationships", "ents", column: "related_ent_id", name: "ents_ent_advanced_relationships_fk2"
  add_foreign_key "ent_advanced_relationships", "ents", name: "ents_ent_advanced_relationships_fk1"
  add_foreign_key "ent_advanced_relationships_temporal", "ent_advanced_relationship_types", name: "ent_advanced_relationship_types_ent_advanced_relationships_temp"
  add_foreign_key "ent_advanced_relationships_temporal", "ents", column: "related_ent_id", name: "ents_ent_advanced_relationships_temporal_fk2"
  add_foreign_key "ent_advanced_relationships_temporal", "ents", name: "ents_ent_advanced_relationships_temporal_fk1"
  add_foreign_key "ent_relationships", "ent_relationship_types", name: "ent_relationship_types_ent_relationships_fk"
  add_foreign_key "ent_relationships", "ents", column: "related_ent_id", name: "ents_ent_relationships_fk1"
  add_foreign_key "ent_relationships", "ents", name: "ents_ent_relationships_fk"
  add_foreign_key "ent_relationships_temporal", "ent_relationship_types", name: "ent_relationship_types_ent_relationships_temporal_fk"
  add_foreign_key "ent_relationships_temporal", "ents", column: "related_ent_id", name: "ents_ent_relationships_temporal_fk1"
  add_foreign_key "ent_relationships_temporal", "ents", name: "ents_ent_relationships_temporal_fk"
  add_foreign_key "ent_subtypes_map", "ent_subtypes", name: "ent_subtypes_ent_subtypes_map_fk"
  add_foreign_key "entity_contacts", "ents", name: "ents_entity_contacts_fk"
  add_foreign_key "ents", "ent_types", name: "fk_ents_ent_type_id"
  add_foreign_key "ents_market_sector_types", "ents", name: "ents_ents_market_sector_types_fk"
  add_foreign_key "ents_market_sector_types", "market_sector_types", name: "market_sector_types_ents_market_sector_types_fk"
  add_foreign_key "exercised_batch_options", "accountx", column: "entity_sf_account_id", name: "exercised_batch_options_entity_sf_account_id_fk"
  add_foreign_key "exercised_batch_options", "acquisition_options", column: "option_id", name: "exercised_batch_options_option_id_fk"
  add_foreign_key "foreign_application_priority_docs", "pats", name: "pats_foreign_application_priority_docs_fk"
  add_foreign_key "ipc_classes", "ipc_sections", name: "ipc_sections_ipc_classes_fk"
  add_foreign_key "ipc_groups", "ipc_classes", name: "ipc_classes_ipc_groups_fk"
  add_foreign_key "ipc_groups", "ipc_sections", name: "ipc_sections_ipc_groups_fk"
  add_foreign_key "ipc_groups", "ipc_subclasses", name: "ipc_subclasses_ipc_groups_fk"
  add_foreign_key "ipc_subclasses", "ipc_classes", name: "ipc_classes_ipc_subclasses_fk"
  add_foreign_key "ipc_subclasses", "ipc_sections", name: "ipc_sections_ipc_subclasses_fk"
  add_foreign_key "ipc_subgroups", "ipc_classes", name: "ipc_classes_ipc_subgroups_fk"
  add_foreign_key "ipc_subgroups", "ipc_groups", name: "ipc_groups_ipc_subgroups_fk"
  add_foreign_key "ipc_subgroups", "ipc_sections", name: "ipc_sections_ipc_subgroups_fk"
  add_foreign_key "ipc_subgroups", "ipc_subclasses", name: "ipc_subclasses_ipc_subgroups_fk"
  add_foreign_key "ipc_subgroups", "ipc_subgroups", column: "parent_subgroup_id", name: "ipc_subgroups_ipc_subgroups_fk"
  add_foreign_key "lit_annotations", "lit_classification_types", name: "lit_classification_type_lit_annotations_fk"
  add_foreign_key "lit_annotations", "lit_curated_cause_types", name: "lit_currated_cause_types_lit_annotations_fk"
  add_foreign_key "lit_annotations", "lit_types", name: "lit_types_lit_annotations_fk"
  add_foreign_key "lit_annotations", "lits", name: "lits_rpx_casedata_fk"
  add_foreign_key "lit_annotations", "market_sector_types", name: "market_sectors_lits_annotations_fk"
  add_foreign_key "lit_case_stages", "lit_stages", name: "lit_case_stages_lit_stage_id_fkey"
  add_foreign_key "lit_case_stages", "lits", name: "lit_case_stages_lit_id_fkey"
  add_foreign_key "lit_courts", "aliases", name: "aliases_lit_courts_fk"
  add_foreign_key "lit_courts", "lits", name: "lits_lit_court_fk"
  add_foreign_key "lit_document_orphans", "lit_documents", name: "lit_documents_lit_document_orphans_fk"
  add_foreign_key "lit_documents", "file_types", name: "lit_documents_file_type_id_fkey"
  add_foreign_key "lit_documents", "lit_document_statuses", column: "document_status_id", name: "lit_documents_document_status_id_fkey"
  add_foreign_key "lit_documents", "lit_document_types", name: "lit_documents_lit_document_type_id_fkey"
  add_foreign_key "lit_judges_map", "aliases", name: "ent_aliases_lit_judges_fk"
  add_foreign_key "lit_judges_map", "judge_assignment_types", column: "assignment_type_id", name: "assgnment_types_lit_judges_fk"
  add_foreign_key "lit_judges_map", "lits", name: "lits_lit_judges_fk"
  # add_foreign_key "lit_parties", "alias_contacts", name: "alias_contacts_lit_parties_fk"
  add_foreign_key "lit_parties", "aliases", name: "ent_aliases_lit_parties_fk"
  add_foreign_key "lit_parties", "lit_party_types", name: "lit_party_types_lit_parties_fk"
  add_foreign_key "lit_parties", "lits", name: "lits_lit_parties_fk"
  add_foreign_key "lit_parties_representations", "alias_contacts", column: "lawfirm_alias_contact_id", name: "alias_contacts_lit_parties_representations_fk1"
  add_foreign_key "lit_parties_representations", "alias_contacts", column: "lawyer_alias_contact_id", name: "alias_contacts_lit_parties_representations_fk"
  add_foreign_key "lit_parties_representations", "aliases", column: "lawfirm_alias_id", name: "ent_aliases_lit_parties_representations_fk1"
  add_foreign_key "lit_parties_representations", "aliases", column: "lawyer_alias_id", name: "ent_aliases_lit_parties_representations_fk"
  add_foreign_key "lit_parties_representations", "lit_parties", column: "lit_parties_id", name: "lit_parties_lit_party_representations_fk"
  add_foreign_key "lit_party_outcomes", "lit_parties", column: "lit_parties_id", name: "lit_parties_lit_party_outcomes_fk"
  # add_foreign_key "lit_party_outcomes", "lit_party_outcome_type_subtype_map", column: "lit_party_outcome_type_id", primary_key: "lit_party_outcome_type_id", name: "lit_parties_lit_party_outcomes_fk1"
  add_foreign_key "lit_party_types", "lit_party_normalized_types", column: "lit_party_normalized_type", primary_key: "name", name: "lit_party_normalized_types_fk"
  add_foreign_key "lit_relationships", "lit_families", name: "lit_relationships_lit_families_fk"
  add_foreign_key "lit_relationships", "lit_relationship_types", name: "lit_relationship_types_lit_relationships_fk"
  add_foreign_key "lit_relationships", "lits", column: "from_lit_id", name: "lits_lit_relationships_fk"
  add_foreign_key "lit_relationships", "lits", column: "to_lit_id", name: "lits_lit_relationships_fk1"
  add_foreign_key "lits", "lit_cause_types", column: "lit_cause_id", name: "lit_causes_lits_fk"
  add_foreign_key "lits_pats_map", "lits", name: "lits_lits_pats_map_fk"
  # add_foreign_key "log_data", "logging.log_levels", column: "log_level_id", name: "log_data__log_levels_fk"
  # add_foreign_key "log_data", "logging.log_levels", column: "log_level_id", name: "log_data__log_levels_fk"
  # add_foreign_key "log_data", "logging.log_levels", column: "log_level_id", name: "log_data__log_levels_fk"
  # add_foreign_key "log_data", "logging.log_levels", column: "log_level_id", name: "log_data__log_levels_fk"
  add_foreign_key "pat_abstracts", "pats", name: "pats_abst_fk"
  add_foreign_key "pat_assignments", "alias_contacts", column: "correspondent_alias_contact_id", name: "alias_contacts_pat_assignments_fk"
  add_foreign_key "pat_assignments", "aliases", column: "correspondent_alias_id", name: "aliases_assignments_fk"
  # add_foreign_key "pat_assignments", "patent_conveyance_normalization.primary_conveyance_logic", column: "primary_conveyance_logic_id", name: "fk_primary_conveyance_logic_id"
  add_foreign_key "pat_assignments_assoc_r_f", "pat_assignments", name: "fk_pat_assignment_id"
  add_foreign_key "pat_claim_relationships", "pat_claims", column: "pat_claims_id", name: "pat_claims_pat_claim_relationships_fk"
  add_foreign_key "pat_claims", "pats", name: "patents_claims_fk"
  add_foreign_key "pat_cross_ref_classes", "pats", name: "pats_pats_cross_ref_classes_fk"
  add_foreign_key "pat_current", "pat_maintenance_code", column: "maintenance_code_id", name: "pat_maint_code_pat_current_fk"
  add_foreign_key "pat_descriptions", "pats", name: "pats_descr_fk"
  add_foreign_key "pat_documents", "pats", name: "patents_pat_documents_fk"
  add_foreign_key "pat_drawings", "pats", name: "patents_drawings_fk"
  add_foreign_key "pat_family_pats", "pat_families", name: "pat_families_id_fk"
  add_foreign_key "pat_ipc_classes", "pats", name: "pats_pat_ipc_classes_fk"
  add_foreign_key "pat_maintenance_fee_events", "pat_maintenance_fee_entity_types", name: "pat_maintenance_fee_events_pat_maintenance_fee_entity_type__fke"
  add_foreign_key "pat_maintenance_fee_events", "pat_maintenance_fee_event_types", name: "pat_maintenance_fee_events_pat_maintenance_fee_event_type__fkey"
  add_foreign_key "pat_maintenance_fee_events", "pats", name: "pats_pat_maintenance_fee_events_fk"
  add_foreign_key "pat_other_references", "pats", name: "pats_orfs_fk"
  add_foreign_key "pat_reissue_number", "pats", name: "pat_reissue_number_pat_id_fkey"
  add_foreign_key "pat_related_documents", "pats", name: "pats_rupd_fk"
  add_foreign_key "pat_secondary_conveyance", "pat_assignments", name: "fk_par_assignamnts"
  add_foreign_key "pat_secondary_conveyance", "pat_secondary_conveyance_types", name: "fk_pat_secondary_conveyance_types"
  add_foreign_key "pat_stats_continuances", "pat_stats", column: "pat_stats_id", name: "pat_stats_pat_stats_continuances_fk"
  add_foreign_key "pat_stats_current_assignees", "aliases", name: "aliases_pat_stats_current_assignees_fk"
  add_foreign_key "pat_stats_current_assignees", "pat_stats", column: "pat_stats_id", name: "pat_stats_pat_stats_current_assignees_fk"
  add_foreign_key "pat_stats_sponsoring_parties", "aliases", name: "alias_id_fk"
  add_foreign_key "pat_stats_sponsoring_parties", "pat_stats", column: "pat_stats_id", name: "pat_stats_pat_stats_sponsoring_parties_fk"
  add_foreign_key "patents", "documents"
  add_foreign_key "pats_aliases_map", "alias_contacts", name: "alias_contacts_pats_aliases_map_fk"
  add_foreign_key "pats_aliases_map", "aliases", name: "aliases_pats_aliases_map_fk"
  add_foreign_key "pats_aliases_map", "pats", name: "pats_pats_aliases_map_fk"
  add_foreign_key "pats_aliases_map", "pats_aliases_relationship_types", name: "pats_aliases_relationship_types_pats_aliases_map_fk"
  add_foreign_key "pats_assignments_map", "pat_assignments", name: "pat_assignments_pats_assignments_map_fk"
  add_foreign_key "pats_assignments_map", "pat_document_types", column: "document_type_id", name: "pat_document_types_pats_assignments_map_fk"
  add_foreign_key "portfolios", "acquisitions", name: "acquisition_portfolio_fk"
  add_foreign_key "ptab_annotations", "lit_types", column: "case_type_id", name: "ptab_annotations_case_type_id_fkey"
  add_foreign_key "ptab_annotations", "ptab_cases", name: "ptab_annotations_ptab_case_id_fkey"
  add_foreign_key "ptab_case_details", "ptab_case_detail_party_types", name: "case_details_party_types_ptab_case_details_fk"
  add_foreign_key "ptab_case_details", "ptab_cases", name: "cases_case_details_fk"
  add_foreign_key "ptab_case_relationships", "ptab_cases", column: "joined_case_id", name: "ptab_case_relationships_joined_case_id_fkey"
  add_foreign_key "ptab_case_relationships", "ptab_cases", column: "lead_case_id", name: "ptab_case_relationships_lead_case_id_fkey"
  add_foreign_key "ptab_cases", "ptab_case_types", name: "ptab_cases_case_types_fk"
  add_foreign_key "ptab_cases", "technology_centers", column: "tech_center", primary_key: "tech_center_number", name: "technology_centers_cases_fk"
  add_foreign_key "ptab_judges_map", "aliases", column: "judge_alias_id", name: "ptab_judges_map_judge_alias_id_fkey"
  add_foreign_key "ptab_judges_map", "ptab_cases", name: "ptab_judges_map_ptab_case_id_fkey"
  add_foreign_key "ptab_parties", "aliases", name: "core_aliases_parties_fk"
  add_foreign_key "ptab_parties", "ptab_cases", name: "ptab_cases_parties_fk"
  add_foreign_key "ptab_parties", "ptab_party_types", name: "party_types_parties_fk"
  # add_foreign_key "rpx_cpi_asset_tracking_log", "logging.log_levels", column: "log_level_id", name: "rpx_cpi_asset_tracking_log__log_levels_fk"
  add_foreign_key "selected_batch_generated_option_types", "acquisition_options", column: "option_id", name: "selected_batch_generated_option_types_option_id_fk"
  add_foreign_key "selected_batch_generated_option_types", "batch_generated_option_types", name: "selected_batch_generated_option_types_batch_generated_option_ty"
  add_foreign_key "seller_documents", "file_types", column: "file_type_id", name: "file_type_id_fk"
  add_foreign_key "uspcs_subclasses", "uspcs_classes", name: "uspcs_classes_uspcs_subclasses_fk"
  add_foreign_key "uspcs_subclasses", "uspcs_subclasses", column: "parent_uspcs_subclass_id", name: "uspcs_subclasses_uspcs_subclasses_fk"
end
