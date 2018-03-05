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
  $('#lit-documents').dataTable
    sPaginationType: 'full_numbers'
    iDisplayLength: 50
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#lit-documents').data('source')
    aoColumns: [
      {"mData": "case_key"},
      {"mData": "filed_date"},
      {"mData": "total_docs"}
    ]

  $('#fileupload').fileupload
    dropZone: $('#dropzone')
    dataType: 'json'
    start: (e, data) ->
      $("#dropzone").html("Upload stated...")
    stop: (e, data) ->
      $("#dropzone").html("Drop files here...")
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

  $('#dropzone').bind 'dragover', (e) ->
    dropZone = $('#dropzone')
    timeout = window.dropZoneTimeout
    if timeout
      clearTimeout timeout
    else
      dropZone.addClass 'in'
    hoveredDropZone = $(e.target).closest(dropZone)
    dropZone.toggleClass 'hover', hoveredDropZone.length
    window.dropZoneTimeout = setTimeout((->
      window.dropZoneTimeout = null
      dropZone.removeClass 'in hover'
    ), 100)

  $('.switch-to-bulk-upload').on 'click', (e) ->
    $parent = $(this).parents('.queue-litigation-row')
    $parent.find('.select2-container').toggleClass('hidden')
    $parent.find('.bulk-upload').toggleClass('hidden')

    $linkText = if $(this).text() == 'Switch to Bulk Upload' then 'Switch to Autocomplete' else 'Switch to Bulk Upload'
    $(this).text($linkText)
    e.preventDefault()
