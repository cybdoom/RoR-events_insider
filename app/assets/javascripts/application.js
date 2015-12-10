//
//= require auth
//= require modals
//= require location
//= require_self
//= require tinymce
//

$(document).ready(function(){
  $(document).ajaxStart(function() {
    $('#spinner-modal').modal('show');
  });

  $(document).ajaxComplete(function() {
    $('#spinner-modal').modal('hide');
  });

  var date_format = 'YYYY-MM-DD';

  $('.date-range').daterangepicker({
    locale: {
      format: date_format
    }
  });

  // $('#date-range').dateRangePicker( {
  //   startOfWeek: 'monday',
  //   separator: ' ~ ',
  //   format: 'DD.MM.YYYY',
  //   autoClose: false,
  //   showShortcuts: false,
  // });

});

