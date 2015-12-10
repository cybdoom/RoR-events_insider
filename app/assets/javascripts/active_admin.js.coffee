#= require active_admin/base
#= require tinymce

$ ->
  tinymce.init
    selector: 'textarea'
    toolbar: ['styleselect | bold italic | undo redo', 'uploadimage | link']
    plugins: ['image link uploadimage']
