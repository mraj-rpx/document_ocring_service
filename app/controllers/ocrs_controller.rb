class OcrsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :require_signin

  def patents
    documents = params.values.select{ |param| param.is_a?(ActionDispatch::Http::UploadedFile) }
    documents = Document.create(documents.map{ |document| {file: document} })

    patent_details = PatentDetailExtractor.new(documents).extract!
    render json: patent_details
  end
end
