class DocumentsController < ApplicationController
  def index
  end

  def create
    @document = Document.create(file: params[:files][0])
    render json: {files: [@document.to_jq_upload]}, status: :created, location: @document
  end

  def destroy
  end
end
