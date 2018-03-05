class DocumentsOcrStatusesController < ApplicationController
  def lit_documents
    @presenter = DocumentsOcrStatusPresenter.new(params)

    respond_to do |format|
      format.html
      format.json { render json: @presenter.as_json }
    end
  end
end
