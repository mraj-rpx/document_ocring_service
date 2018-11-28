class DocumentsOcrStatusesController < ApplicationController
  def lit_documents
    @presenter = DocumentsOcrStatusPresenter.new(params)

    respond_to do |format|
      format.html
      format.json { render json: @presenter.as_json }
    end
  end

  def ptab_documents
    @ptab_ocrable_count = PtabCaseDetail.ocrable_docs_for_backfill.count
    @ptab_ocred_count = PtabCaseDetail.ocred_docs.count
    @ptab_total_docs_doctype = PtabCaseDetail.total_docs_on_doc_types
    @ptab_ocred_docs_doctype = PtabCaseDetail.ocred_docs_on_doc_types
    @ptab_ocrable_docs_doctype = PtabCaseDetail.ocrable_docs_on_doc_types
  end

  def app_data_documents
    @appdata_ocrable_count = PairOcr.ocrable_documents.count
    @appdata_ocred_count = PairOcr.ocred_documents.count
    @app_data_total_doc_priority = PairOcr.total_documents_on_priority
    @app_data_ocred_docs_priority = PairOcr.ocred_documents_on_priority
    @app_data_ocrable_docs_priority = PairOcr.ocrable_documents_on_priority
  end
end
