$(document).ready(function() {

  /* Pop up */
  $(".popup").on("click", '.close, .cancel', function() {
    $(this).closest('.popup-container').hide();
  });

  /* Date Picker */
  var documentHeight = $(document).height();
  $(".popup-container").height(documentHeight);
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