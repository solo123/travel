$(document).ajaxStart(function(){
  $("#progress").slideDown();
});
$(document).ajaxStop(function(){
  $("#progress").slideUp();
});

$(function(){ 
	$('.dialog-normal').dialog({ autoOpen: false, width: 700});
	$('ul.sf-menu').superfish(); 
  $('.date-picker').datepicker({ showButtonPanel: true, dateFormat: 'yy-mm-dd' });
  $('.small-button').button({icons:{primary:'ui-icons-pencil'}});
});

