$(document).ready(function() {

  /* Pop up */

  $('#signup').modal('show');

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

/* */

function checkPassword() {
  var password = document.getElementById('password');
  var confirmPassword = document.getElementById('confirm-password');
  var message = document.getElementById('confirm-message');
  var goodColor = "#66cc66";
  var badColor = "#ff6666";
  if (password.value == confirmPassword.value) {
    message.style.color = goodColor;
    message.innerHTML = "Passwords Match!"
  } else {
    message.style.color = badColor;
    message.innerHTML = "Passwords Do Not Match!"
  }
}