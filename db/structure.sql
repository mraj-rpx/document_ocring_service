SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = acquiflow, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: manual_assets; Type: TABLE; Schema: acquiflow; Owner: -
--

CREATE TABLE manual_assets (
    id integer NOT NULL,
    client character varying(200),
    run_date character varying(30),
    case_number character varying(200),
    country character varying(200),
    wipo character varying(200),
    subcase character varying(200),
    client_division character varying(200),
    case_type character varying(200),
    status character varying(200),
    application_number character varying(200),
    filing_date date,
    patent_number character varying(200),
    issue_date date,
    publication_number character varying(200),
    publication_date date,
    expiration_date date,
    title text,
    db_comments character varying(20),
    db_query character varying(500),
    core_pats_id integer,
    docdb_pats_id integer,
    acquisition_id character varying(20),
    portfolio_id character varying(50),
    right_type character varying(200),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    created_by character varying(64) DEFAULT "current_user"(),
    updated_by character varying(64) DEFAULT "current_user"(),
    batch_number character varying(30),
    patnum character varying(32) DEFAULT NULL::character varying
);


--
-- Name: manual_assets_id_seq; Type: SEQUENCE; Schema: acquiflow; Owner: -
--

CREATE SEQUENCE manual_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manual_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: acquiflow; Owner: -
--

ALTER SEQUENCE manual_assets_id_seq OWNED BY manual_assets.id;


SET search_path = core, pg_catalog;

--
-- Name: pats_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE pats_id_seq
    START WITH 7966777
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pats; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE pats (
    id integer DEFAULT nextval('pats_id_seq'::regclass) NOT NULL,
    patnum character varying(255) NOT NULL,
    foreign_app_data character varying(2048),
    doc_kind_code character varying(2048),
    title character varying(2048) NOT NULL,
    int_cross_ref_class character varying(2048),
    fapd_doc_listing character varying(2048),
    related_app character varying(2048),
    us_class_at_publication character varying(2048),
    app_filing_date date,
    reissue_data_section_label character varying(2048),
    foreign_app_priority_data character varying(2048),
    pct_num character varying(2048),
    pct_pub_num character varying(2048),
    ipc_cross_ref_class character varying(2048),
    field_of_search character varying(4096),
    pct_pub_date date,
    cross_ref_at_publication character varying(2048),
    us_class_current character varying(2048),
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    amended_claims_pub_date date,
    app_num_country character varying(2048),
    app_num_intl character varying(2048),
    intl_class character varying(2048),
    intl_class_current character varying(2048),
    intl_class_edition character varying(2048),
    issue_date date,
    pct_102_date date,
    pct_371_date date,
    pct_filed_date date,
    publication_date date,
    publication_number character varying(255),
    lastmod character(14),
    term_extension integer DEFAULT 0,
    term_disclaimer character varying(255),
    salesforce_id character varying(18),
    stripped_patnum character varying(32),
    country_code character varying(16),
    is_application boolean DEFAULT true NOT NULL,
    earliest_filing_date date,
    term_expiratoin_date date,
    last_submission_pat_id integer DEFAULT '-1'::integer NOT NULL,
    next_submission_pat_id integer,
    orig_app_num_country character varying(32) DEFAULT 'undefined'::character varying NOT NULL,
    is_dcl_corrected boolean,
    formal_number character varying(32),
    is_digital_record boolean DEFAULT true
);


--
-- Name: COLUMN pats.patnum; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.patnum IS 'US + patent number + kind code';


--
-- Name: COLUMN pats.foreign_app_data; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.foreign_app_data IS 'tds:fapp
Foreign Application Data. From applications, not patents. Use FADL for document listings';


--
-- Name: COLUMN pats.doc_kind_code; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.doc_kind_code IS 'tds:pkcd
Document Kind Code – Optional on some document types, required on others, but allowed on all.';


--
-- Name: COLUMN pats.title; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.title IS 'tds:titl
Patent Title – ENGLISH';


--
-- Name: COLUMN pats.int_cross_ref_class; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.int_cross_ref_class IS 'tds:crci
International cross ref class. 0 or more entries in file. One entry per CRCI line. Same format as CLSI.';


--
-- Name: COLUMN pats.fapd_doc_listing; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.fapd_doc_listing IS 'tds:fadl
Document Listing for FAPD. Text date, or yyyymmdd, then [2 letter country code]';


--
-- Name: COLUMN pats.related_app; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.related_app IS 'tds:rela
“Related Application:” In US documents this data is often in the descriptive text and will not appear in this section.  AppNum, Date, relationship (CON, CIP, Parent, etc) may be listed on a single line entry.';


--
-- Name: COLUMN pats.us_class_at_publication; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.us_class_at_publication IS 'tds:uscp
U.S. Class at Publication: US Applications and Grants Classification at Publication time.';


--
-- Name: COLUMN pats.app_filing_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.app_filing_date IS 'tds:apdt
Appl. filing date - format YYYYMMDD" - always follows APNS, or APNO.';


--
-- Name: COLUMN pats.reissue_data_section_label; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.reissue_data_section_label IS 'tds:reis
Reissue Data Section Label';


--
-- Name: COLUMN pats.foreign_app_priority_data; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.foreign_app_priority_data IS 'tds:fapd
For US:Foreign Application Priority Data For WO/EPPriority Data. Label that Heralds FADL entries';


--
-- Name: COLUMN pats.pct_num; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.pct_num IS 'tds:pcno
PCT No.';


--
-- Name: COLUMN pats.pct_pub_num; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.pct_pub_num IS 'tds:ppnm
PCT Pub number';


--
-- Name: COLUMN pats.ipc_cross_ref_class; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.ipc_cross_ref_class IS 'tds:ccri
IPC Cross Ref classes. Same format as CCSI';


--
-- Name: COLUMN pats.field_of_search; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.field_of_search IS 'tds:foss
Field of Search: Only in EPB is electronic A3 available (scanned search reports cant be used). Field of Search - 1st class/subclass entry - omit prior to first FOS entry';


--
-- Name: COLUMN pats.pct_pub_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.pct_pub_date IS 'tds:ppdt
PCT PUB. Date: PCT Filing Date';


--
-- Name: COLUMN pats.cross_ref_at_publication; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.cross_ref_at_publication IS 'tds:uccp
Cross Ref. Classes at document publication time. One UCCP entry for each cross reference classifications assigned (e.g., 1 per line). 0 or more entries.';


--
-- Name: COLUMN pats.us_class_current; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.us_class_current IS 'tds:clsu
Current U.S. Class: US Class/Subclass';


--
-- Name: COLUMN pats.amended_claims_pub_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.amended_claims_pub_date IS 'tds:damc
Date of Publication of Amended Claims: This applies to the current document (which has the amendments)';


--
-- Name: COLUMN pats.app_num_country; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.app_num_country IS 'tds:apnc
Application number (country specific)';


--
-- Name: COLUMN pats.app_num_intl; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.app_num_intl IS 'tds:apni
Application number (international style)';


--
-- Name: COLUMN pats.intl_class; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.intl_class IS 'tds:clsi
”Intern''l Class: “Int. Cl.”  “International Class:” See: Notes on US and International Class formats at the end of this table.  (a.k.a. “IPC”). A single line of data with 2 to 4 items.';


--
-- Name: COLUMN pats.intl_class_current; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.intl_class_current IS 'tds:ccsi
Current Intern''l Class. See: Notes on US and International Class formats at the end of this table. Optionally generated from database. Date of classification (or reclassification) may also be stored on line after the class in parenthesis: B41J 002/175 (YYYYMMDD)';


--
-- Name: COLUMN pats.intl_class_edition; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.intl_class_edition IS 'tds:cice
“International Class Edition” This is an optional field and is not included on all documents. See: Notes on US and International Class formats at the end of this table.  This is an optional single digit (usually 4 through 8) that indicates what edition of the international specification the class information was produced under.';


--
-- Name: COLUMN pats.issue_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.issue_date IS 'tds:issd
“Date of Patent:” (USB) “Date of Publication and mention of the grant of patent:” (EPB) Date the patent grant was issued by the patent authority.';


--
-- Name: COLUMN pats.pct_102_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.pct_102_date IS 'tds:p102
PCT 102(e) Date';


--
-- Name: COLUMN pats.pct_371_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.pct_371_date IS 'tds:p371
PCT 371 Date';


--
-- Name: COLUMN pats.pct_filed_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.pct_filed_date IS 'tds:pcfd
PCT Filed: Filed Date';


--
-- Name: COLUMN pats.publication_number; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.publication_number IS 'publication number';


--
-- Name: COLUMN pats.lastmod; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.lastmod IS 'last modified timestamp from TDS in YYYYMMDDhhmmss GMT.';


--
-- Name: COLUMN pats.stripped_patnum; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.stripped_patnum IS 'This column contains the central piece of the patnum column, with the two digit country prefix and the kind code suffix stripped off.';


--
-- Name: COLUMN pats.country_code; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.country_code IS 'This column contains the two digit country code prefix from the patnum column.';


--
-- Name: COLUMN pats.is_application; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN pats.is_application IS 'This column determines whether the record represents an application or a finalized patent. If true the record is for an application, if false the record is an approved patent.';


SET search_path = docdb, pg_catalog;

--
-- Name: docdb_pats_id_seq; Type: SEQUENCE; Schema: docdb; Owner: -
--

CREATE SEQUENCE docdb_pats_id_seq
    START WITH 900000000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = rpx_user_default;

--
-- Name: docdb_pats; Type: TABLE; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE TABLE docdb_pats (
    id integer DEFAULT nextval('docdb_pats_id_seq'::regclass) NOT NULL,
    patnum character varying(255),
    is_representative character varying(10),
    originating_office character varying(25),
    status character varying(25),
    filedate character varying,
    title text,
    title_lang character varying(255),
    family_id integer,
    stripped_patnum character varying(255),
    extended_kind_code character varying(255),
    app_num_intl character varying(25),
    app_num_country character varying(25),
    lang_of_publication character varying(25),
    lang_of_filing character varying(25),
    updated_at timestamp without time zone,
    created_at timestamp without time zone,
    doc_kind_code character varying(10),
    publication_number character varying(255),
    app_is_representative character varying(255),
    app_kind_code character varying(255),
    date_of_coming_into_force character varying(255),
    previously_filed_app character varying(255),
    country_code character varying(255),
    public_availability_category character varying(255),
    batch_id integer,
    run_id integer,
    publication_date_history character varying(255) DEFAULT ''::character varying,
    issue_date date,
    app_date date,
    date_of_last_exchange date,
    date_of_previous_exchange date,
    publication_date date,
    date_added_docdb date,
    preceding_publication_date date,
    public_availability_date date,
    doc_number character varying(255),
    pat_family_processed boolean
);


SET search_path = ptab, pg_catalog;

SET default_tablespace = '';

--
-- Name: ptab_cases; Type: TABLE; Schema: ptab; Owner: -
--

CREATE TABLE ptab_cases (
    id integer NOT NULL,
    case_num character varying(20) NOT NULL,
    filing_date date NOT NULL,
    institution_decision_date date,
    stripped_patnum character varying(10),
    country_code character varying NOT NULL,
    application_num character varying(10),
    status character varying(64) NOT NULL,
    tech_center character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(15) NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_by character varying(15) NOT NULL,
    ptab_case_type_id integer,
    is_dcl_corrected boolean DEFAULT false,
    final_decision_date date,
    final_outcome_date date,
    notice_date date,
    reason_for_notice_filing_date text,
    final_decision_outcome text,
    final_outcome text,
    petitioner_application_num character varying(10),
    petitioner_stripped_patnum character varying(10),
    petitioner_tech_center character varying(100),
    missing_from_source_date date,
    is_open boolean
);


--
-- Name: COLUMN ptab_cases.stripped_patnum; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_cases.stripped_patnum IS 'Patent Number from the ptab site';


--
-- Name: COLUMN ptab_cases.application_num; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_cases.application_num IS 'application number from the ptab site';


--
-- Name: COLUMN ptab_cases.final_decision_date; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_cases.final_decision_date IS 'Final Written Decision Date';


--
-- Name: COLUMN ptab_cases.final_outcome_date; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_cases.final_outcome_date IS 'Final Outcome Date';


--
-- Name: COLUMN ptab_cases.notice_date; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_cases.notice_date IS 'Date of Notice of Accorded Filing Date';


--
-- Name: COLUMN ptab_cases.reason_for_notice_filing_date; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_cases.reason_for_notice_filing_date IS 'Source of Notice Date or reason why it is not available';


SET search_path = core, pg_catalog;

--
-- Name: lit_documents_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE lit_documents_id_seq
    START WITH 9556206
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = rpx_user_default;

--
-- Name: lit_documents; Type: TABLE; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE TABLE lit_documents (
    id integer DEFAULT nextval('lit_documents_id_seq'::regclass) NOT NULL,
    docketx_id character varying(36),
    doc_num integer,
    de_seq_num integer,
    dm_id integer,
    url character varying(255) NOT NULL,
    lit_document_type_id integer DEFAULT 0,
    file_type_id integer DEFAULT 0,
    rpx_file_name character varying(255),
    rpx_file_location character varying(255),
    document_status_id integer DEFAULT 1 NOT NULL,
    document_status_message text,
    case_key character varying(30),
    updated_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    old_id integer,
    no_of_pages integer,
    ocr_text text,
    pdf_type character varying,
    billable_pages integer,
    cost double precision
);


--
-- Name: TABLE lit_documents; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE lit_documents IS 'Electronically filed documents (from PACER)';


--
-- Name: COLUMN lit_documents.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.id IS 'Lit Document ID (key connects to docket_entry_documents_map)';


--
-- Name: COLUMN lit_documents.docketx_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.docketx_id IS 'DocketX document ID (docketx: document.id)';


--
-- Name: COLUMN lit_documents.doc_num; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.doc_num IS 'Parameter for document URL';


--
-- Name: COLUMN lit_documents.de_seq_num; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.de_seq_num IS 'Parameter for document URL';


--
-- Name: COLUMN lit_documents.dm_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.dm_id IS 'Parameter for document URL';


--
-- Name: COLUMN lit_documents.url; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.url IS 'Document URL (docketx: document.documenturl)';


--
-- Name: COLUMN lit_documents.updated_at; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.updated_at IS 'Date and time the record was last updated. Controlled automatically by the database.';


--
-- Name: COLUMN lit_documents.created_at; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.created_at IS 'Date and time the record was created. Controlled automatically by the database.';


--
-- Name: COLUMN lit_documents.pdf_type; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN lit_documents.pdf_type IS 'plain pdf or scanned pdf, when the pdf contains scanned images.';


SET default_tablespace = '';

--
-- Name: file_types; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE file_types (
    id integer NOT NULL,
    description character varying(50),
    is_default boolean,
    updated_at timestamp without time zone,
    created_at timestamp without time zone
);


--
-- Name: file_types_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE file_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_types_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE file_types_id_seq OWNED BY file_types.id;


--
-- Name: lit_document_statuses; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE lit_document_statuses (
    id integer NOT NULL,
    description character varying(50),
    note text,
    is_default boolean,
    updated_at timestamp without time zone,
    created_at timestamp without time zone
);


--
-- Name: lit_document_statuses_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE lit_document_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lit_document_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE lit_document_statuses_id_seq OWNED BY lit_document_statuses.id;


--
-- Name: lit_document_types; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE lit_document_types (
    id integer NOT NULL,
    description character varying(50),
    is_default boolean DEFAULT false,
    updated_at timestamp without time zone,
    created_at timestamp without time zone,
    is_archived boolean
);


--
-- Name: lit_document_types_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE lit_document_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lit_document_types_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE lit_document_types_id_seq OWNED BY lit_document_types.id;


SET search_path = ptab, pg_catalog;

--
-- Name: ptab_case_details; Type: TABLE; Schema: ptab; Owner: -
--

CREATE TABLE ptab_case_details (
    id integer NOT NULL,
    ptab_case_id integer NOT NULL,
    ptab_case_detail_party_type_id integer NOT NULL,
    doc_name character varying(500) NOT NULL,
    doc_type character varying(100),
    exhibit_num integer NOT NULL,
    filing_date date NOT NULL,
    availability character varying(50) NOT NULL,
    document_path character varying(300),
    attachment_handle character varying(100),
    attachment_url character varying(500),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(15) NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_by character varying(15) NOT NULL,
    is_dcl_corrected boolean DEFAULT false,
    attachment_type character varying(100),
    missing_from_source_date date,
    attachment_name character varying(500),
    ocr_text text,
    ocr_completed_at timestamp without time zone,
    needs_ocr boolean DEFAULT false,
    ocr_exception text
);


--
-- Name: COLUMN ptab_case_details.document_path; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_case_details.document_path IS 'Path of the document in Amazon S3 is stored in this field.';


--
-- Name: COLUMN ptab_case_details.missing_from_source_date; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_case_details.missing_from_source_date IS 'Date when we finalized (after confirming after multiple crawls) that this record is no longer in the site';


SET search_path = document_ocr_service, pg_catalog;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: document_ocr_service; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: documents; Type: TABLE; Schema: document_ocr_service; Owner: -
--

CREATE TABLE documents (
    id bigint NOT NULL,
    ocr_text text,
    file character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 1,
    exception character varying
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: document_ocr_service; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: document_ocr_service; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: patents; Type: TABLE; Schema: document_ocr_service; Owner: -
--

CREATE TABLE patents (
    id bigint NOT NULL,
    patnum character varying,
    asset_source integer,
    asset_source_id integer,
    patent_number integer,
    country_code character varying,
    matched_with_country_code boolean DEFAULT true,
    document_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: patents_id_seq; Type: SEQUENCE; Schema: document_ocr_service; Owner: -
--

CREATE SEQUENCE patents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patents_id_seq; Type: SEQUENCE OWNED BY; Schema: document_ocr_service; Owner: -
--

ALTER SEQUENCE patents_id_seq OWNED BY patents.id;


SET search_path = ptab, pg_catalog;

--
-- Name: ptab_case_detail_party_types; Type: TABLE; Schema: ptab; Owner: -
--

CREATE TABLE ptab_case_detail_party_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying(15) NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_by character varying(15) NOT NULL,
    is_default boolean
);


--
-- Name: COLUMN ptab_case_detail_party_types.name; Type: COMMENT; Schema: ptab; Owner: -
--

COMMENT ON COLUMN ptab_case_detail_party_types.name IS 'Filing Party value from ptab website in documents page';


--
-- Name: ptab_case_detail_party_types_id_seq; Type: SEQUENCE; Schema: ptab; Owner: -
--

CREATE SEQUENCE ptab_case_detail_party_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ptab_case_detail_party_types_id_seq; Type: SEQUENCE OWNED BY; Schema: ptab; Owner: -
--

ALTER SEQUENCE ptab_case_detail_party_types_id_seq OWNED BY ptab_case_detail_party_types.id;


--
-- Name: ptab_case_details_id_seq; Type: SEQUENCE; Schema: ptab; Owner: -
--

CREATE SEQUENCE ptab_case_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ptab_case_details_id_seq; Type: SEQUENCE OWNED BY; Schema: ptab; Owner: -
--

ALTER SEQUENCE ptab_case_details_id_seq OWNED BY ptab_case_details.id;


--
-- Name: ptab_cases_id_seq; Type: SEQUENCE; Schema: ptab; Owner: -
--

CREATE SEQUENCE ptab_cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ptab_cases_id_seq; Type: SEQUENCE OWNED BY; Schema: ptab; Owner: -
--

ALTER SEQUENCE ptab_cases_id_seq OWNED BY ptab_cases.id;


SET search_path = public, pg_catalog;

--
-- Name: dual; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW dual AS
 SELECT 'X'::character varying AS dummy;


--
-- Name: passwd; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE passwd (
    username text,
    pass text,
    uid integer,
    gid integer,
    gecos text,
    home text,
    shell text
)
SERVER file_server
OPTIONS (
    delimiter ':',
    filename '/etc/passwd',
    format 'text',
    "null" ''
);


--
-- Name: pg_stat_activity; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW pg_stat_activity AS
 SELECT pg_stat_activity.pid AS procpid,
    pg_stat_activity.usesysid,
    pg_stat_activity.usename,
    pg_stat_activity.application_name,
    pg_stat_activity.client_addr,
    pg_stat_activity.client_hostname,
    pg_stat_activity.client_port,
    pg_stat_activity.backend_start,
    pg_stat_activity.xact_start,
    pg_stat_activity.query_start,
    pg_stat_activity.state_change,
    pg_stat_activity.waiting,
    pg_stat_activity.state,
    pg_stat_activity.query
   FROM pg_catalog.pg_stat_activity;


--
-- Name: ps_activity_log; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW ps_activity_log AS
 SELECT postgres_log.log_time,
    postgres_log.user_name,
    postgres_log.process_id,
    postgres_log.connection_from,
    postgres_log.command_tag,
    postgres_log.session_start_time,
    postgres_log.error_severity,
        CASE
            WHEN (postgres_log.message ~* '^duration: '::text) THEN regexp_replace(postgres_log.message, '^duration: [0-9]*.[0-9]* ms  '::text, ''::text)
            ELSE postgres_log.message
        END AS query_text,
        CASE
            WHEN (postgres_log.message ~* '^duration: '::text) THEN (regexp_replace(regexp_replace(postgres_log.message, '^duration\:\ '::text, ''::text), '.[0-9]+ ms(.)*'::text, ''::text))::integer
            ELSE NULL::integer
        END AS "duration(ms)",
    postgres_log.detail,
    postgres_log.query
   FROM rpx_dba.postgres_log
  ORDER BY postgres_log.log_time DESC;


--
-- Name: ps_etl_app_conn_snapshot; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW ps_etl_app_conn_snapshot AS
 SELECT user_connections.user_name,
    user_connections.ip_address,
    user_connections.connected_time,
    user_connections.query_time,
    user_connections.query_ddl,
    user_connections.recorded_at
   FROM rpx_dba.user_connections
  WHERE (((user_connections.user_name)::text = 'ps_etl_app'::text) AND (user_connections.recorded_at = '2013-05-07 14:15:06.199924'::timestamp without time zone));


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: v_rpx_app_roles; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_rpx_app_roles AS
 SELECT DISTINCT pg_roles.rolname AS groupname,
    pg_user.usename AS username
   FROM ((pg_user
     JOIN pg_auth_members ON ((pg_user.usesysid = pg_auth_members.member)))
     JOIN pg_roles ON ((pg_roles.oid = pg_auth_members.roleid)))
  WHERE ((pg_roles.rolname)::text = ANY (ARRAY['ro_group'::text, 'rpx'::text, 'rpx_api'::text, 'rpx_service'::text, 'dblink_role'::text, 'localcore'::text, 'coreapp'::text, 'application_role'::text]));


--
-- Name: v_rpx_consultants; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_rpx_consultants AS
 SELECT ldap_imaginea.full_name,
    ldap_imaginea.department,
    ldap_imaginea.username,
    ldap_imaginea.email,
    ldap_imaginea.telephone,
    ldap_imaginea.mobile
   FROM ldap_etl_app.ldap_imaginea
  WHERE (((ldap_imaginea.full_name)::text !~* 'test'::text) AND ((ldap_imaginea.full_name)::text !~* 'investor re'::text) AND (((ldap_imaginea.full_name)::text ~ '^[A-Z][a-z](.)* [A-Z][a-z](.)*$'::text) OR ((ldap_imaginea.full_name)::text ~ '^[A-Z].(.)* [A-Z][a-z](.)*$'::text)));


--
-- Name: v_rpx_employees; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_rpx_employees AS
 SELECT ldap_people.full_name,
    ldap_people.department,
    ldap_people.username,
    ldap_people.email,
    ldap_people.telephone,
    ldap_people.mobile
   FROM ldap_etl_app.ldap_people
  WHERE (((ldap_people.full_name)::text !~* 'test'::text) AND ((ldap_people.full_name)::text !~* 'investor re'::text) AND (((ldap_people.full_name)::text ~ '^[A-Z][a-z](.)* [A-Z][a-z](.)*$'::text) OR ((ldap_people.full_name)::text ~ '^[A-Z].(.)* [A-Z][a-z](.)*$'::text)));


--
-- Name: v_rpx_sysdev; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW v_rpx_sysdev AS
 SELECT ldap_sysdev.full_name,
    ldap_sysdev.department,
    ldap_sysdev.username,
    ldap_sysdev.email,
    ldap_sysdev.telephone,
    ldap_sysdev.mobile
   FROM ldap_etl_app.ldap_sysdev
  WHERE (((ldap_sysdev.full_name)::text !~* 'test'::text) AND ((ldap_sysdev.full_name)::text !~* 'investor re'::text) AND (((ldap_sysdev.full_name)::text ~ '^[A-Z][a-z](.)* [A-Z][a-z](.)*$'::text) OR ((ldap_sysdev.full_name)::text ~ '^[A-Z].(.)* [A-Z][a-z](.)*$'::text)));


SET search_path = acquiflow, pg_catalog;

--
-- Name: manual_assets id; Type: DEFAULT; Schema: acquiflow; Owner: -
--

ALTER TABLE ONLY manual_assets ALTER COLUMN id SET DEFAULT nextval('manual_assets_id_seq'::regclass);


SET search_path = core, pg_catalog;

--
-- Name: file_types id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY file_types ALTER COLUMN id SET DEFAULT nextval('file_types_id_seq'::regclass);


--
-- Name: lit_document_statuses id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_document_statuses ALTER COLUMN id SET DEFAULT nextval('lit_document_statuses_id_seq'::regclass);


--
-- Name: lit_document_types id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_document_types ALTER COLUMN id SET DEFAULT nextval('lit_document_types_id_seq'::regclass);


SET search_path = document_ocr_service, pg_catalog;

--
-- Name: documents id; Type: DEFAULT; Schema: document_ocr_service; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: patents id; Type: DEFAULT; Schema: document_ocr_service; Owner: -
--

ALTER TABLE ONLY patents ALTER COLUMN id SET DEFAULT nextval('patents_id_seq'::regclass);


SET search_path = ptab, pg_catalog;

--
-- Name: ptab_case_detail_party_types id; Type: DEFAULT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_detail_party_types ALTER COLUMN id SET DEFAULT nextval('ptab_case_detail_party_types_id_seq'::regclass);


--
-- Name: ptab_case_details id; Type: DEFAULT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_details ALTER COLUMN id SET DEFAULT nextval('ptab_case_details_id_seq'::regclass);


--
-- Name: ptab_cases id; Type: DEFAULT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_cases ALTER COLUMN id SET DEFAULT nextval('ptab_cases_id_seq'::regclass);


SET search_path = acquiflow, pg_catalog;

--
-- Name: manual_assets manual_assets_pkey; Type: CONSTRAINT; Schema: acquiflow; Owner: -
--

ALTER TABLE ONLY manual_assets
    ADD CONSTRAINT manual_assets_pkey PRIMARY KEY (id);


SET search_path = core, pg_catalog;

--
-- Name: file_types file_types_description_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY file_types
    ADD CONSTRAINT file_types_description_key UNIQUE (description);


--
-- Name: lit_document_statuses lit_document_statuses_description_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_document_statuses
    ADD CONSTRAINT lit_document_statuses_description_key UNIQUE (description);


--
-- Name: lit_document_statuses lit_document_statuses_pk; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_document_statuses
    ADD CONSTRAINT lit_document_statuses_pk PRIMARY KEY (id);


--
-- Name: lit_document_types lit_document_types_description_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_document_types
    ADD CONSTRAINT lit_document_types_description_key UNIQUE (description);


--
-- Name: lit_document_types lit_document_types_pk; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_document_types
    ADD CONSTRAINT lit_document_types_pk PRIMARY KEY (id);


SET default_tablespace = rpx_user_default;

--
-- Name: lit_documents lit_documents_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: rpx_user_default
--

ALTER TABLE ONLY lit_documents
    ADD CONSTRAINT lit_documents_pkey PRIMARY KEY (id);


SET default_tablespace = '';

--
-- Name: file_types lit_file_types_pk; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY file_types
    ADD CONSTRAINT lit_file_types_pk PRIMARY KEY (id);


--
-- Name: pats pats_pk; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY pats
    ADD CONSTRAINT pats_pk PRIMARY KEY (id);


SET search_path = docdb, pg_catalog;

SET default_tablespace = rpx_user_default;

--
-- Name: docdb_pats docdb_pats_pkey; Type: CONSTRAINT; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

ALTER TABLE ONLY docdb_pats
    ADD CONSTRAINT docdb_pats_pkey PRIMARY KEY (id);


SET search_path = document_ocr_service, pg_catalog;

SET default_tablespace = '';

--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: document_ocr_service; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: document_ocr_service; Owner: -
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: patents patents_pkey; Type: CONSTRAINT; Schema: document_ocr_service; Owner: -
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT patents_pkey PRIMARY KEY (id);


SET search_path = ptab, pg_catalog;

--
-- Name: ptab_case_details attachment_handle_unique_idx; Type: CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_details
    ADD CONSTRAINT attachment_handle_unique_idx UNIQUE (attachment_handle);


--
-- Name: ptab_case_detail_party_types ptab_case_detail_type_unique_name; Type: CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_detail_party_types
    ADD CONSTRAINT ptab_case_detail_type_unique_name UNIQUE (name);


--
-- Name: ptab_case_details ptab_case_details_pk; Type: CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_details
    ADD CONSTRAINT ptab_case_details_pk PRIMARY KEY (id);


--
-- Name: ptab_cases ptab_cases_pk; Type: CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_cases
    ADD CONSTRAINT ptab_cases_pk PRIMARY KEY (id);


--
-- Name: ptab_case_detail_party_types ptab_filing_party_types_pk; Type: CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_detail_party_types
    ADD CONSTRAINT ptab_filing_party_types_pk PRIMARY KEY (id);


SET search_path = acquiflow, pg_catalog;

--
-- Name: manual_assets_patnum_country_idx; Type: INDEX; Schema: acquiflow; Owner: -
--

CREATE INDEX manual_assets_patnum_country_idx ON manual_assets USING btree (patent_number, country);


SET search_path = core, pg_catalog;

SET default_tablespace = rpx_user_default;

--
-- Name: idx_lit_documents_normalized_file_name; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX idx_lit_documents_normalized_file_name ON lit_documents USING btree (regexp_replace((rpx_file_name)::text, '.*\/.*\/.*\/'::text, ''::text));


SET default_tablespace = '';

--
-- Name: idx_pats_intl_class; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX idx_pats_intl_class ON pats USING btree (intl_class);


SET default_tablespace = rpx_user_default;

--
-- Name: idx_pats_last_submission_pat_id1; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX idx_pats_last_submission_pat_id1 ON pats USING btree (last_submission_pat_id);


--
-- Name: idx_pats_next_submission_pat_id1; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX idx_pats_next_submission_pat_id1 ON pats USING btree (next_submission_pat_id);


--
-- Name: idx_pats_orig_app_num_country; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX idx_pats_orig_app_num_country ON pats USING btree (orig_app_num_country);


SET default_tablespace = '';

--
-- Name: idx_pats_title_gin; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX idx_pats_title_gin ON pats USING gin (title public.gin_trgm_ops);


SET default_tablespace = rpx_user_default;

--
-- Name: lit_documents__url_uniq_idx; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE UNIQUE INDEX lit_documents__url_uniq_idx ON lit_documents USING btree (url);


SET default_tablespace = '';

--
-- Name: lit_documents_created_at_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX lit_documents_created_at_idx ON lit_documents USING btree (created_at);


--
-- Name: lit_documents_updated_at_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX lit_documents_updated_at_idx ON lit_documents USING btree (updated_at);


--
-- Name: pats__app_num_country_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX pats__app_num_country_idx ON pats USING btree (app_num_country);


SET default_tablespace = rpx_user_default;

--
-- Name: pats__created_at_idx; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX pats__created_at_idx ON pats USING btree (created_at);


--
-- Name: pats__is_application_idx; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX pats__is_application_idx ON pats USING btree (is_application);


SET default_tablespace = '';

--
-- Name: pats__patnum_unique_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX pats__patnum_unique_idx ON pats USING btree (patnum);


--
-- Name: pats__salesforce_id_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX pats__salesforce_id_idx ON pats USING btree (salesforce_id);


SET default_tablespace = rpx_user_default;

--
-- Name: pats__stripped_patnum_doc_kind_code_unique_idx; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE UNIQUE INDEX pats__stripped_patnum_doc_kind_code_unique_idx ON pats USING btree (stripped_patnum, doc_kind_code);


--
-- Name: pats__updated_at_idx; Type: INDEX; Schema: core; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX pats__updated_at_idx ON pats USING btree (updated_at);


SET default_tablespace = '';

--
-- Name: pats_stripped_patnum_country_code_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX pats_stripped_patnum_country_code_idx ON pats USING btree (stripped_patnum, country_code);


--
-- Name: pats_stripped_patnum_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX pats_stripped_patnum_idx ON pats USING gin (stripped_patnum public.gin_trgm_ops);


SET search_path = docdb, pg_catalog;

SET default_tablespace = rpx_user_default;

--
-- Name: docdb_pats__created_at_idx; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX docdb_pats__created_at_idx ON docdb_pats USING btree (created_at);


--
-- Name: docdb_pats__updated_at_idx; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX docdb_pats__updated_at_idx ON docdb_pats USING btree (updated_at);


--
-- Name: docdb_pats_app_num_country_idx; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX docdb_pats_app_num_country_idx ON docdb_pats USING btree (app_num_intl, app_num_country);


SET default_tablespace = '';

--
-- Name: docdb_pats_app_num_country_idx1; Type: INDEX; Schema: docdb; Owner: -
--

CREATE INDEX docdb_pats_app_num_country_idx1 ON docdb_pats USING btree (app_num_country);


SET default_tablespace = rpx_user_default;

--
-- Name: docdb_pats_lower_idx; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX docdb_pats_lower_idx ON docdb_pats USING btree (lower((patnum)::text) varchar_pattern_ops);


--
-- Name: docdb_pats_pat_family_processed_idx; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX docdb_pats_pat_family_processed_idx ON docdb_pats USING btree (pat_family_processed);


--
-- Name: docdb_pats_patnum_idx; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX docdb_pats_patnum_idx ON docdb_pats USING btree (patnum);


SET default_tablespace = '';

--
-- Name: docdb_pats_patnum_idx1; Type: INDEX; Schema: docdb; Owner: -
--

CREATE INDEX docdb_pats_patnum_idx1 ON docdb_pats USING gin (patnum public.gin_trgm_ops);


SET default_tablespace = rpx_user_default;

--
-- Name: docdb_pats_stripped_patnum_country_idx; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX docdb_pats_stripped_patnum_country_idx ON docdb_pats USING btree (stripped_patnum, country_code);


--
-- Name: idx_docdb_pats_family_id; Type: INDEX; Schema: docdb; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX idx_docdb_pats_family_id ON docdb_pats USING btree (family_id);


SET search_path = ptab, pg_catalog;

SET default_tablespace = '';

--
-- Name: idx_ptab_case_stripped_patnum_country; Type: INDEX; Schema: ptab; Owner: -
--

CREATE INDEX idx_ptab_case_stripped_patnum_country ON ptab_cases USING btree (stripped_patnum, country_code);


SET default_tablespace = rpx_user_default;

--
-- Name: idx_ptab_cases_case_num; Type: INDEX; Schema: ptab; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX idx_ptab_cases_case_num ON ptab_cases USING btree (case_num);


SET default_tablespace = '';

--
-- Name: ptab_case_details_ptab_case_id_idx; Type: INDEX; Schema: ptab; Owner: -
--

CREATE INDEX ptab_case_details_ptab_case_id_idx ON ptab_case_details USING btree (ptab_case_id);


SET default_tablespace = rpx_user_default;

--
-- Name: ptab_cases__created_at_idx; Type: INDEX; Schema: ptab; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX ptab_cases__created_at_idx ON ptab_cases USING btree (created_at);


--
-- Name: ptab_cases__updated_at_idx; Type: INDEX; Schema: ptab; Owner: -; Tablespace: rpx_user_default
--

CREATE INDEX ptab_cases__updated_at_idx ON ptab_cases USING btree (updated_at);


SET search_path = public, pg_catalog;

SET default_tablespace = '';

--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = acquiflow, pg_catalog;

--
-- Name: manual_assets manual_assets_audit; Type: TRIGGER; Schema: acquiflow; Owner: -
--

CREATE TRIGGER manual_assets_audit BEFORE INSERT OR DELETE OR UPDATE ON manual_assets FOR EACH ROW EXECUTE PROCEDURE acquiflow_audit.manual_assets_aud_tr_func();


SET search_path = core, pg_catalog;

--
-- Name: file_types file_types_audit; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER file_types_audit BEFORE INSERT OR DELETE OR UPDATE ON file_types FOR EACH ROW EXECUTE PROCEDURE core_audit.file_types_aud_tr_func();


--
-- Name: lit_document_statuses lit_document_statuses_audit; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER lit_document_statuses_audit BEFORE INSERT OR DELETE OR UPDATE ON lit_document_statuses FOR EACH ROW EXECUTE PROCEDURE core_audit.lit_document_statuses_aud_tr_func();


--
-- Name: lit_document_types lit_document_types_audit; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER lit_document_types_audit BEFORE INSERT OR DELETE OR UPDATE ON lit_document_types FOR EACH ROW EXECUTE PROCEDURE core_audit.lit_document_types_aud_tr_func();


--
-- Name: lit_documents lit_documents_audit; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER lit_documents_audit BEFORE INSERT OR DELETE OR UPDATE ON lit_documents FOR EACH ROW EXECUTE PROCEDURE core_audit.lit_documents_aud_tr_func();


--
-- Name: lit_documents lit_documents_insert_timestamps; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER lit_documents_insert_timestamps BEFORE INSERT ON lit_documents FOR EACH ROW EXECUTE PROCEDURE insert_timestamps();


--
-- Name: lit_documents lit_documents_update_timestamp; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER lit_documents_update_timestamp BEFORE UPDATE ON lit_documents FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: pats pats_audit; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER pats_audit BEFORE INSERT OR DELETE OR UPDATE ON pats FOR EACH ROW EXECUTE PROCEDURE core_audit.pats_aud_tr_func();


--
-- Name: pats pats_insert_timestamps; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER pats_insert_timestamps BEFORE INSERT ON pats FOR EACH ROW EXECUTE PROCEDURE insert_timestamps();


--
-- Name: pats pats_update_timestamp; Type: TRIGGER; Schema: core; Owner: -
--

CREATE TRIGGER pats_update_timestamp BEFORE UPDATE ON pats FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


SET search_path = docdb, pg_catalog;

--
-- Name: docdb_pats docdb_pats_audit; Type: TRIGGER; Schema: docdb; Owner: -
--

CREATE TRIGGER docdb_pats_audit BEFORE INSERT OR DELETE OR UPDATE ON docdb_pats FOR EACH ROW EXECUTE PROCEDURE docdb_audit.docdb_pats_aud_tr_func();


SET search_path = ptab, pg_catalog;

--
-- Name: ptab_case_detail_party_types ptab_case_detail_party_types_audit; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_case_detail_party_types_audit BEFORE INSERT OR DELETE OR UPDATE ON ptab_case_detail_party_types FOR EACH ROW EXECUTE PROCEDURE ptab_audit.ptab_case_detail_party_types_aud_tr_func();


--
-- Name: ptab_case_detail_party_types ptab_case_detail_pary_types_update_timestamp; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_case_detail_pary_types_update_timestamp BEFORE UPDATE ON ptab_case_detail_party_types FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: ptab_case_details ptab_case_details_audit; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_case_details_audit BEFORE INSERT OR DELETE OR UPDATE ON ptab_case_details FOR EACH ROW EXECUTE PROCEDURE ptab_audit.ptab_case_details_aud_tr_func();


--
-- Name: ptab_case_details ptab_case_details_update_timestamp; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_case_details_update_timestamp BEFORE UPDATE ON ptab_case_details FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


--
-- Name: ptab_cases ptab_case_status_change; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_case_status_change BEFORE INSERT OR UPDATE ON ptab_cases FOR EACH ROW EXECUTE PROCEDURE case_status_change_tr_function();


--
-- Name: ptab_cases ptab_cases_audit; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_cases_audit BEFORE INSERT OR DELETE OR UPDATE ON ptab_cases FOR EACH ROW EXECUTE PROCEDURE ptab_audit.ptab_cases_aud_tr_func();


--
-- Name: ptab_cases ptab_cases_update_campaign; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_cases_update_campaign AFTER INSERT OR UPDATE ON ptab_cases FOR EACH ROW EXECUTE PROCEDURE update_campaign_tr_function();


--
-- Name: ptab_cases ptab_cases_update_timestamp; Type: TRIGGER; Schema: ptab; Owner: -
--

CREATE TRIGGER ptab_cases_update_timestamp BEFORE UPDATE ON ptab_cases FOR EACH ROW EXECUTE PROCEDURE update_timestamp();


SET search_path = core, pg_catalog;

--
-- Name: lit_documents lit_documents_document_status_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_documents
    ADD CONSTRAINT lit_documents_document_status_id_fkey FOREIGN KEY (document_status_id) REFERENCES lit_document_statuses(id);


--
-- Name: lit_documents lit_documents_file_type_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_documents
    ADD CONSTRAINT lit_documents_file_type_id_fkey FOREIGN KEY (file_type_id) REFERENCES file_types(id);


--
-- Name: lit_documents lit_documents_lit_document_type_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY lit_documents
    ADD CONSTRAINT lit_documents_lit_document_type_id_fkey FOREIGN KEY (lit_document_type_id) REFERENCES lit_document_types(id);


SET search_path = document_ocr_service, pg_catalog;

--
-- Name: patents fk_rails_e62b251a38; Type: FK CONSTRAINT; Schema: document_ocr_service; Owner: -
--

ALTER TABLE ONLY patents
    ADD CONSTRAINT fk_rails_e62b251a38 FOREIGN KEY (document_id) REFERENCES documents(id);


SET search_path = ptab, pg_catalog;

--
-- Name: ptab_case_details case_details_party_types_ptab_case_details_fk; Type: FK CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_details
    ADD CONSTRAINT case_details_party_types_ptab_case_details_fk FOREIGN KEY (ptab_case_detail_party_type_id) REFERENCES ptab_case_detail_party_types(id);


--
-- Name: ptab_case_details cases_case_details_fk; Type: FK CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_case_details
    ADD CONSTRAINT cases_case_details_fk FOREIGN KEY (ptab_case_id) REFERENCES ptab_cases(id);


--
-- Name: ptab_cases ptab_cases_case_types_fk; Type: FK CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_cases
    ADD CONSTRAINT ptab_cases_case_types_fk FOREIGN KEY (ptab_case_type_id) REFERENCES ptab_case_types(id);


--
-- Name: ptab_cases technology_centers_cases_fk; Type: FK CONSTRAINT; Schema: ptab; Owner: -
--

ALTER TABLE ONLY ptab_cases
    ADD CONSTRAINT technology_centers_cases_fk FOREIGN KEY (tech_center) REFERENCES technology_centers(tech_center_number);


--
-- PostgreSQL database dump complete
--

SET search_path TO document_ocr_service,core,public,ptab,acquiflow,docdb;

INSERT INTO "schema_migrations" (version) VALUES
('20110825003212'),
('20110916050811'),
('20111024231645'),
('20111129010223'),
('20111130120006'),
('20111212222217'),
('20111221132800'),
('20111230093200'),
('20120103115100'),
('20120709180850'),
('20150327104114'),
('20150327104815'),
('20150406105200'),
('20150408043158'),
('20150422162948'),
('20150512125619'),
('20150513071100'),
('20150521100038'),
('20150604111105'),
('20150608071944'),
('20150616124135'),
('20150618064236'),
('20150702102649'),
('20150713053003'),
('20150717131249'),
('20150721090905'),
('20150721091650'),
('20150721091743'),
('20150722093150'),
('20150728115126'),
('20150731060953'),
('20150731105059'),
('20150731120548'),
('20150804100344'),
('20150812134850'),
('20150826072615'),
('20150826122540'),
('20150826125536'),
('20150827090814'),
('20150904104158'),
('20150904104218'),
('20150904104232'),
('20150904121150'),
('20150907071257'),
('20150907080744'),
('20150908090211'),
('20150909060234'),
('20150911071534'),
('20150911080541'),
('20150918075403'),
('20150928060444'),
('20150928093344'),
('20151006064231'),
('20151020090629'),
('20151020113605'),
('20151020123429'),
('20151020135939'),
('20151021121236'),
('20151123034024'),
('20151208055859'),
('20151208133648'),
('20151209201801'),
('20151210065514'),
('20151216060112'),
('20151221130918'),
('20151224045139'),
('20151228055317'),
('20151228164033'),
('20151229114045'),
('20151230091431'),
('20151230125116'),
('20160103165807'),
('20160104122607'),
('20160104124109'),
('20160105091643'),
('20160106055517'),
('20160106094320'),
('20160108072000'),
('20160108072458'),
('20160111070719'),
('20160112084749'),
('20160113125506'),
('20160118194438'),
('20160119091028'),
('20160120110520'),
('20160122093609'),
('20160127114208'),
('20160127114356'),
('20160128062343'),
('20160128065452'),
('20160128093510'),
('20160128120421'),
('20160211051052'),
('20160217091244'),
('20160224062825'),
('20160224063650'),
('20160307112537'),
('20160307113027'),
('20160307113549'),
('20160307114007'),
('20160310104256'),
('20160311131547'),
('20160314111701'),
('20160315055400'),
('20160315061043'),
('20160330105719'),
('20160404113023'),
('20160404114043'),
('20160404114247'),
('20160404114718'),
('20160404115115'),
('20160421071526'),
('20160422111024'),
('20160425073810'),
('20160426015756'),
('20160427070749'),
('20160503063445'),
('20160503064902'),
('20160503065013'),
('20160505115723'),
('20160520102659'),
('20160523065014'),
('20160524095544'),
('20160526061419'),
('20160608055517'),
('20160627121600'),
('20160704103627'),
('20160704110006'),
('20160704111748'),
('20160705130234'),
('20160713110524'),
('20160713124623'),
('20160714062841'),
('20160726051940'),
('20160803095651'),
('20160816080558'),
('20160923092935'),
('20161005131108'),
('20161010071838'),
('20161010072038'),
('20161109123638'),
('20161109125309'),
('20161115120104'),
('20161115122156'),
('20161128113947'),
('20170222063203'),
('20170421124036'),
('20170516063719'),
('20170530085616'),
('20170710104900'),
('20170711122357'),
('20170711144947'),
('20170718074744'),
('20170907085116');


