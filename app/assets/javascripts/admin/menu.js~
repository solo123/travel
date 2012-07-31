$(document).ajaxStart(function(){
  $("#progress").slideDown();
});
$(document).ajaxStop(function(){
  $("#progress").slideUp();
});

function set_small_buttons(){
  $('.small-button').each( function(){
    var icon = $(this).attr('ui_icon');
    $(this).button({icons: {primary: icon}});
  });
}
$(function(){ 
	$('.dialog-normal').dialog({ autoOpen: false, width: 700});
	$('ul.sf-menu').superfish(); 
  $('.date-picker').datepicker({ showButtonPanel: true, dateFormat: 'yy-mm-dd' });
  set_small_buttons();
});

var test = 'ok';
