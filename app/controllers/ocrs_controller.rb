class OcrsController < ApplicationController
  protect_from_forgery with: :null_session

  def patents
    documents = params.values.select{ |param| param.is_a?(ActionDispatch::Http::UploadedFile) }
    patent_details = PatentDetailExtractor.new(documents).patent_details

    render json: patent_details
  end
end
