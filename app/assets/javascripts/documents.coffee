jQuery ->
  $('#documents').dataTable
    sPaginationType: "full_numbers"
    iDisplayLength: 5
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#documents').data('source')
    aaSorting: [ [0, 'desc'] ]
    aoColumns: [
      {"mData": "id", "bSortable": false},
      { "mData": "file", "bSortable": true}
      { "mData": "view_ocr_text", "bSortable": false}
      { "mData": "view_patents", "bSortable": false}
      ]
