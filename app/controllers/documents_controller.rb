class DocumentsController < ApplicationController
  before_action :set_document, only: [:ocr_text, :patents]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DocumentsDatatable.new(view_context) }
    end
  end

  def create
    @document = Document.create(file: params[:files][0])
    render json: {files: [@document.to_jq_upload]}, status: :created, location: @document
  end

  def destroy
  end

  def upload_documents
  end

  def ocr_text
  end

  def upload_new_documents
    @document = Document.create(file: params[:files][0], status: :todo_from_ui)
    render json: { files: [@document.to_jq_upload] }, status: :created, location: @document
  end

  def patents
    @patents = @document.patents
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end
end
