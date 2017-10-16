$(document).on 'turbolinks:load', ->
  $('#documents').dataTable
    sPaginationType: "full_numbers"
    iDisplayLength: 25
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#documents').data('source')
    aaSorting: [ [0, 'desc'] ]
    aoColumns: [
      {"mData": "id", "bSortable": true},
      { "mData": "file", "bSortable": true}
      { "mData": "view_ocr_text", "bSortable": false}
      { "mData": "view_patents", "bSortable": false}
      { "mData": "status", "bSortable": false}
      ]

  $('#fileupload').fileupload
    dataType: 'json'
    done: (e, data) ->
      $.each data.result.files, (index, file) ->
        $('<li/>').addClass('list-group-item').text(file.name).appendTo($('#uploaded-files'))
    fail: (e, data) ->
      alert('Could not upload the file and the error is: ' + data.response().errorThrown)

  $('.select2-autocomplete').select2
    theme: 'bootstrap'
    maximumSelectionLength: -1
    multiple: true
    minimumInputLength: 2
    maximumInputLength: 20
    width: 'style'
