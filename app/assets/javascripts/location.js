$(document).ready(function(){
  
  var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
      var matches, substringRegex;
      // an array that will be populated with substring matches
      matches = [];
      // regex used to determine if a string contains the substring `q`
      substrRegex = new RegExp(q, 'i');
      // iterate through the pool of strings and for any string that
      // contains the substring `q`, add it to the `matches` array
      $.each(strs, function(i, str) {
        if (substrRegex.test(str)) {
          matches.push(str);
        }
      });
   
      cb(matches);
    };
  };
 
  // variable for the autocomplete - can replace with json data.
  var states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
    'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii',
    'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
    'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
    'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
    'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
    'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
    'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
    'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
  ];
 
  $('#the-basics .typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'states',
    source: substringMatcher(states)
  });

  function hideInput(){
    $('.add-location').hide();
    $(".autocomplete input[type='text']").hide(400);
  }

  function getValue(){
    var val = $('.typeahead.tt-input').val();
    $('.autocomplete').append("<address><h3><a href=''>"+val+"</a></h3>"
      + "<span>42 Greenwich Ave</span><span>Boston, MA</span>"
      + "<p>Actual Location / Special Instructions<br>Parking in the lot at this address, but come to 801b Merchantile Highway.</p>"
      + "</address> <img class='address-map' src='/assets/map-placeholder.png'/>"
      + "<span class='distance'>20 miles from you in Boston, MA</span> " );    
    hideInput();
  }
  
  $(".tt-menu").prepend("<span class='add-location'>Add as new location</span>");
  
  $(".add-location").click(function() {
    alert("adding location");
    var val = $('.typeahead.tt-input').val();
    $('.autocomplete').append("<h3><a href=''>"+val+"</a></h3>");   
    hideInput();

  });
  
  $('.tt-dataset').click(function() {
    setTimeout(getValue, 300);
  });
  
  $(".typeahead").keyup(function(){
    $('.tt-menu').show();
  });
    
  /* Cancel */
  $('.cancel').click(function(){
    document.getElementById('light').style.display='none';
    document.getElementById('fade').style.display='none';
  });
    
});