class DocumentsOcrStatusPresenter < Struct.new(:options)
  attr_accessor :ocred_count, :ocrable_count, :ocred_cases

  def initialize(options = {})
    self.options = options

    @offset = self.options[:iDisplayStart] || 0
    @limit = self.options[:iDisplayLength] || 50
  end

  def lit_docs_ocred_count
    @lit_docs_ocred_count ||= fetch_record(:count, true)
  end

  def lit_docs_ocrable_count
    @lit_docs_ocrable_count ||= fetch_record(:count, false)
  end

  def lit_docs_ocred_cases
    @lit_docs_ocred_cases ||= fetch_record(:cases, true)
  end

  def as_json
    {
      sEcho: options[:sEcho].to_i,
      iTotalRecords: lit_docs_ocred_count,
      iTotalDisplayRecords: lit_docs_ocred_count,
      aaData: lit_docs_ocred_cases.map{|lit|
        {case_key: lit.case_key, filed_date: lit.filed_date, total_docs: lit.total_doc_count}
      }
    }
  end

  private

  def fetch_record(qry_opt, ocred = true)
    with_qry =<<-QUERY
      WITH
      all_cases
      as
      (
      SELECT
          DISTINCT
          de.lit_id,
          lits.case_key,
          ld.id as doc_id,
          ld.ocr_text_s3_path,
          lits.filed_date
      FROM
      core.docket_entries de
      INNER JOIN core.lits ON de.lit_id = lits.id
      INNER JOIN core.docket_entry_documents_map ded_all ON de.id = ded_all.docket_entry_id
      INNER JOIN core.lit_documents ld ON ld.id = ded_all.lit_document_id AND ld.document_status_id = 3
      INNER JOIN core.lit_document_types ldt ON ld.lit_document_type_id = ldt.id
      AND ld.lit_document_type_id in (1,34,4,5,7,21,11,10,33,13,75,16,17,18)
      )
    QUERY

    condition_qry =<<-QUERY
      SELECT case_key,
      filed_date,
      COUNT(distinct doc_id) AS total_doc_count,
      COUNT(distinct case WHEN ocr_text_s3_path IS NOT NULL THEN doc_id ELSE NULL END) AS ocred_count,
      COUNT(distinct case WHEN ocr_text_s3_path IS NULL THEN doc_id ELSE NULL END) AS non_ocred_count
      FROM
      all_cases
      GROUP BY 1,2
      HAVING COUNT(DISTINCT doc_id) #{ocred == true ? '=' : '<>'} COUNT(DISTINCT CASE WHEN ocr_text_s3_path IS NOT NULL THEN doc_id ELSE NULL END)
    QUERY

    select_qry = qry_opt == :count ? "SELECT COUNT(1) FROM (#{condition_qry})t" : "#{condition_qry} ORDER BY filed_date DESC OFFSET (?) LIMIT (?)"
    final_query = "#{with_qry} #{select_qry}"
    qry_opt == :count ? Lit.find_by_sql(final_query)[0]['count'] : Lit.find_by_sql([final_query, @offset, @limit])
  end
end