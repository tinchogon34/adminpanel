$(document).ready(function(){                        

  $('#nav-expander').on('click',function(e){
    e.preventDefault();
    $('body').toggleClass('nav-expanded');
  });
       
  $('#nav-close').on('click',function(e){
    e.preventDefault();
    $('body').removeClass('nav-expanded');
  });

  $(".container").on('click', function(){
    $('body').removeClass('nav-expanded');
  });
});