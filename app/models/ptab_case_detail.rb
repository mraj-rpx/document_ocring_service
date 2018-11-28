class PtabCaseDetail < ApplicationRecord
  self.table_name = 'ptab_case_details'

  DOC_TYPES = ['ptab_petition', 'ptab_final_decision', 'ptab_institution_decision', 'ptab_termination']

  belongs_to :ptab_case
  has_many :docs, foreign_key: :lit_document_id

  scope :ocrable_docs, -> { where(needs_ocr: true).order(:ocr_priority) }

  scope :ptab_document_types, -> { joins(:ptab_case, :docs).where('(docs.docs.document_type ~* ? OR lower(doc_type) ILIKE ? OR lower(doc_name) ILIKE ?)', 'ptab', '%notice of appeal%', '%notice of appeal%') }

  scope :ocrable_documents, -> { self.ptab_document_types.order('ptab_cases.created_at DESC')
  }
  scope :ocrable_docs_for_backfill, -> { self.ocrable_documents.where('ocr_text_s3_path IS NULL AND ocr_text IS NULL')}
  scope :ocred_docs, -> { self.ocrable_documents.where('ocr_text_s3_path IS NOT NULL')}

  scope :total_docs_on_doc_types, -> { self.ptab_document_types.select("coalesce(doc_type
    , doc_name) as doc_type, count(*)").group("coalesce(doc_type, doc_name)") }
  scope :ocred_docs_on_doc_types, -> { self.ptab_document_types.where('ocr_text_s3_path IS NOT NULL')
    .select("coalesce(doc_type, doc_name) as doc_type, count(*)")
    .group("coalesce(doc_type, doc_name)") }
  scope :ocrable_docs_on_doc_types, -> { self.ptab_document_types.where('ocr_text_s3_path IS NULL AND ocr_text IS NULL')
    .select("coalesce(doc_type, doc_name) as doc_type, count(*)")
    .group("coalesce(doc_type, doc_name)") }
end
