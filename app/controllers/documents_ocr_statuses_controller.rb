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
  end
end
