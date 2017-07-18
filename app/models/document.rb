class Document < ApplicationRecord
  include Rails.application.routes.url_helpers
  mount_uploader :file, DocumentUploader
  enum status: { todo_from_api: 1, todo_from_ui: 2, inprogress: 3, completed: 4, failed: 5 }

  has_many :patents

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
