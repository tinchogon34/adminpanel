$(function(){
  hide_alert();
});

function hide_alert(){
  setTimeout(function(){
    $('.alert').fadeOut(500);
  },3000);
}