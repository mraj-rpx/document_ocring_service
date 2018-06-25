class PtabCaseDetail < ApplicationRecord
  self.table_name = 'ptab_case_details'

  DOC_TYPES = ['ptab_petition', 'ptab_final_decision', 'ptab_institution_decision', 'ptab_termination']

  belongs_to :ptab_case
  has_many :docs, foreign_key: :lit_document_id

  scope :ocrable_docs, -> { where(needs_ocr: true).order(:ocr_priority) }

  scope :ocrable_documents, -> {
    joins(:ptab_case, :docs).where('(docs.docs.document_type ~* ? OR lower(doc_type) ILIKE ?
                                    OR lower(doc_name) ILIKE ?)',
                                   'ptab', '%notice of appeal%', '%notice of appeal%').order('ptab_cases.created_at DESC')
  }
  scope :ocrable_docs_for_backfill, -> { self.ocrable_documents.where('ocr_text_s3_path IS NULL AND ocr_text IS NULL')}
  scope :ocred_docs, -> { self.ocrable_documents.where('ocr_text_s3_path IS NOT NULL')}
end
