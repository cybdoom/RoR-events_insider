$(document).ready(function(){
  $(".nav-mobile-icon").click(function() {
    var $this = $(this);
    if ($this.hasClass('toggle')) {
      $this.removeClass('toggle');
        $("#header-menu").slideUp();
        $(".sub-header").slideDown();
        $("#search-bar").slideUp();
    }
    else {
      $this.addClass('toggle');
      $(".search-mobile-icon").removeClass('toggle');
      $("#header-menu").slideDown();
      $(".sub-header").slideUp();
      $("#search-bar").slideUp();
    }
  });

  $(".search-mobile-icon").click(function(){
    var $this = $(this);
    if ($this.hasClass('toggle')) {
      $this.removeClass('toggle');
      $("#search-bar").slideUp();
      $(".sub-header").slideDown();
      $("#header-menu").slideUp();
    }
    else {
      $this.addClass('toggle');
      $(".nav-mobile-icon").removeClass('toggle');
      $("#search-bar").slideDown();
      $(".sub-header").slideUp();
      $("#header-menu").slideUp();
    }
  });

  $(window).resize(function() {
    if (window.innerWidth > 767) {
      $('#header-menu').removeAttr('style');
      $('#search-bar').removeAttr('style');
      $('.sub-header').removeAttr('style');
    }
  });

});
