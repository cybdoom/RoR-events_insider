$(document)
  .ready(function() {


    /* Pop up */
    var
      documentHeight = $(document).height();
    $(".popup-container").height(documentHeight);

    // $('#datePicker').modal('show');
    $(".popup").on("click", '.close, .cancel', function() {
      $(this).closest('.popup-container').hide();
    });


    /* Date Picker */
    $('#date-range').dateRangePicker({
      startOfWeek: 'monday',
      separator: ' ~ ',
      format: 'DD.MM.YYYY HH:mm',
      autoClose: false,
      showShortcuts: false,
    });

    // var singleTimeInput = "<div class='time-selector'>"
    //                     + "<label>Hour</label><div><span></span><input class='hours' type='text' name='hours' val=''/>" 
    //                     + "<label>Minutes</label><input class='minutes' type='text' name='minutes' val=''/>" 
    //                     + "<label></label><input class='am-pm' type='text name='am-pm' val=''/>";

    var singleTimeInput = "<div class='time-selector'>"
                        + "<input id='hours-spinner' value='08'>"
                        + "<input id='minutes-spinner' value ='00'>"
                        + "<span id='am-pm-spinner'></span>"
                        + "</div>";

    
    $(".month-wrapper").after(singleTimeInput);
     $( "#hours-spinner").spinner({
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
    $( "#minutes-spinner").spinner({
      // min: 0, 
      // max: 60,
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
     
     var dlist = ['am','pm']
     $( "#am-pm-spinner" ).spinner({ 
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

  });


/* Password vs Confirm-Password Checking */
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