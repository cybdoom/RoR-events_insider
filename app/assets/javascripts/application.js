//
//= require auth
//= require modals
//= require location
//= require_self
//

$(document).ready(function(){
  $(document).ajaxStart(function() {
    $('#spinner-modal').modal('show');
  });

  $(document).ajaxComplete(function() {
    $('#spinner-modal').modal('hide');
  });
});
