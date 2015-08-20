$(document).ready(function() {

  PopUpInitate();
  datePickerModule();

  // $(document.body).on('click', '.btn-close', function(event){
  //   $(this).parents('.modal').modal('close');
  // });

  // DECLARATIONS

  // 1.0 PopUp Initate
  // PopupInitate declaration
  function PopUpInitate() {
    var documentHeight = $(document).height();
    $('.popup-container').height(documentHeight);

    $('.popup').on('click', '.close, .cancel', function() {
      $(this).closest('.popup-container').hide();
    });
  }

  // 2.0 Date Picker

  // datePickerModule declaration
  function datePickerModule() {
    datePicketDefault();
    elementModifier();
    dateModuleControls();
    timerFunctionAddon();
  }

  // datePicketDefault declaration
  function datePicketDefault() {
    $('#date-range').dateRangePicker( {
      startOfWeek: 'monday',
      separator: ' ~ ',
      format: 'DD.MM.YYYY',
      autoClose: false,
      showShortcuts: false,
    });
  }

  // elementModifier declaration
  function elementModifier(){
    $('.normal-top').before("<h3 class='mascot-speaks'>Pick a date</h3> <p>Click a date to select it.</p>");
    $('.default-top').html('');
    $('.date-picker-wrapper table .caption .next, .date-picker-wrapper table .caption .prev').html('');
    $('.ui-spinner .ui-spinner-up, .ui-spinner .ui-spinner-up').html();

    var startTimeInput = "<div id='start-time' class='time-selector'>"
                        + "<p>Start Time:</p>"
                        + "<input class='hours-spinner' value='08'>"
                        + "<input class='minutes-spinner' value ='00'>"
                        + "<span class='am-pm-spinner'></span>"
                        + "</div>";
    var endTimeInput = "<div id='end-time' class='time-selector'>"
                        + "<p>End Time:</p>"
                        + "<input class='hours-spinner' value='08'>"
                        + "<input class='minutes-spinner' value ='00'>"
                        + "<span class='am-pm-spinner'></span>"
                        + "</div>";
    var clearDiv  = "<div class'clear'></div>";
    var popUpControl =  "<div class='popup-control'>"
                        + "<button type='button' class='true-btn save'>Save</button>"
                        + "<a class='cancel' href = 'javascript:void(0)'>Cancel</a>"
                        + "</div>";

    $(".month-wrapper").after(startTimeInput, endTimeInput, clearDiv, popUpControl);
    $(".drp_top-bar .apply-btn").remove();
  }

  //dateModuleControls declaration
  function dateModuleControls(){
    $(".date-picker-wrapper a.cancel").on("click", function(){
      $(".date-picker-wrapper").hide();
    });
  }

  // timerFunctionAddon declaration
  function timerFunctionAddon(){
    $( ".hours-spinner").spinner({
      numberFormat: "d2",

      spin: function( event, ui ) {
        if ( ui.value > 11 ) {
          $( this ).spinner( "value", 0 );
          return false;
        } else if ( ui.value < 0 ) {
          $( this ).spinner( "value", 11 );
          return false;
        }
      }
    });

    $( ".minutes-spinner").spinner({
      numberFormat: "d2",

      spin: function( event, ui ) {
        if ( ui.value > 59 ) {
          $( this ).spinner( "value", 0 );
          return false;
        } else if ( ui.value < 0 ) {
          $( this ).spinner( "value", 59 );
          return false;
        }
      }
    });

    var dlist = ['am','pm'];
    $( ".am-pm-spinner" ).spinner({
      create: function(){
        $(this).parent().append('<input class="am-pm-spinner-text" value="'+dlist[0]+'">');
      },

      stop: function(event,ui) {
        $(this).siblings('.am-pm-spinner-text').val(dlist[$(this).val()]);
      },

      spin: function( event, ui ) {
        if ( ui.value > 1 ) {
          $( this ).spinner( "value", 0 );
          return false;
        } else if ( ui.value < 0 ) {
          $( this ).spinner( "value", 1 );
          return false;
        }
      }
    });
  }

});

// 3.0 Date Picker ( called signup modal )
// Password vs Confirm-Password Checking
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
