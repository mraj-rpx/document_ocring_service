class DocumentsController < ApplicationController
  before_action :set_document, only: [:ocr_text, :patents]
  before_action :set_document_ids, only: [:push_documents]

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

  def push_documents_to_queue
  end

  def push_documents
    if @lit_document_ids.present?
      lit_documents = LitDocument.where(id: @lit_document_ids, document_status_id: LitDocument::EXISTING_DOCUMENT_STATUS)
      docs_without_status_3 = @lit_document_ids.map(&:to_i) - lit_documents.map(&:id)
      lit_documents.update_all(needs_ocr: true, ocr_priority: params[:lit_document_priority])
    end

    if @ptab_document_ids.present?
      ptab_documents = PtabCaseDetail.where(id: @ptab_document_ids)
      ptab_documents.update_all(needs_ocr: true, ocr_priority: params[:ptab_document_priority])
    end

    notice_message =<<-EOF
Successfully pushed the core and PTAB litigation documents to OCR queue, except the following documents \
which have not been acquired by the litigation document service: #{docs_without_status_3}.
Please take an appropriate action on these documents if needed.
    EOF
    redirect_back(fallback_location: push_documents_to_queue_documents_path, flash: {alert: notice_message})
  end

  def core_lit_documents
    lit_documents = LitDocument.where('id::text ilike ?', "%#{params[:q]}%").select(:id).limit(50)
    render json: {results: lit_documents.map{ |lit_doc| {id: lit_doc.id, text: lit_doc.id} }}
  end

  def ptab_documents
    ptab_documents = PtabCaseDetail.where('id::text ilike ?', "%#{params[:q]}%").select(:id).limit(50)
    render json: {results: ptab_documents.map{ |ptab_doc| {id: ptab_doc.id, text: ptab_doc.id} }}
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def set_document_ids
    @lit_document_ids = clean_and_extract_ids(params[:lit_documents], params[:core_lit_document_ids])
    @ptab_document_ids = clean_and_extract_ids(params[:ptab_documents], params[:ptab_document_ids])
  end

  def clean_and_extract_ids(bulk_ids, auto_ids)
    (auto_ids || []) + bulk_ids.strip.split(',').reject{ |id| id.blank? }
  end
end
