class Document < ApplicationRecord
  include Rails.application.routes.url_helpers

  mount_uploader :file, DocumentUploader

  def to_jq_upload
    {
      name: file.filename,
      size: file.size,
      url: file.url,
      deleteUrl: document_path(self),
      deleteType: 'DELETE'
    }
  end
end
