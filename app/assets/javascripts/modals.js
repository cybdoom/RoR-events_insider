$(document).ready(function() {

  $document = $(document);
  var documentHeight = $document.height();
  $datePickerContainer = $('.date-picker-container');

  $datePickerContainer.height(documentHeight);
  $document.on("click", function(event) {
    var target = $(event.target);
    var thisElement = event.target.className;

    if (!$datePickerContainer.is(':visible')) {

      if (thisElement == 'date') {
        $datePickerContainer.show();
      }

    } else {

      if (thisElement == 'cancel') {
        $datePickerContainer.hide();
      } else if ((thisElement == 'date-picker') || (!target.parents('.date-picker').length)) {
        $datePickerContainer.hide();
      }

    }

  });

  /* Date Picker */

  var $datesSpan = $(".dates span");

  $datesSpan.on("click", function() {
    var $_this = $(this);
    if (!$_this.hasClass("inactive")) {
      $datesSpan.removeClass("selected");
      $_this.addClass("selected");
    }
  });

  $(".dates span.selected").on("click", function() {
    var $_this = $(this);
    $_this.removeClass("selected");
  });

  $(".time-container label").on("click", function() {
    var $_this = $(this);
    if (!$_this.prev("input:checkbox").is(':checked')) {
      $_this.prev("input:checkbox").prop('checked', true);
    } else {
      $_this.prev("input:checkbox").prop('checked', false);
    }
  });


});