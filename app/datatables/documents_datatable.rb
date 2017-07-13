class DocumentsDatatable
  delegate :params, :link_to, to: :@view_context

  PER_PAGE_LIMIT = 25

  def initialize(view_context)
    @view_context = view_context
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Document.count,
      iTotalDisplayRecords: documents.total_entries,
      aaData: data
    }
  end

  private

  def data
    documents.map do |document|
      {
        id: document.id,
        file: document[:file],
        view_ocr_text: link_to('View', @view_context.ocr_text_document_path(document), {target: '_blank'}),
        view_patents: link_to('View', @view_context.patents_document_path(document), {target: '_blank'})
      }
    end
  end

  def documents
    @documents ||= fetch_documents
  end

  def fetch_documents
    documents = Document.order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    documents = documents.where("file LIKE :search OR ocr_text LIKE :search", {search: "%#{params[:sSearch]}%"}) if params[:sSearch].present?
    documents
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : PER_PAGE_LIMIT
  end

  def sort_column
    columns = %w[file ocr_text]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
