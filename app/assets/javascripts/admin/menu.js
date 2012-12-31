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
function load_logs(){
  $.get('/admin/my_logs/zone', function(data){
    $('#last_logs').html(data);
    $('time.timeago').timeago();
  });
}
function load_todos(){
  $.get('/admin/todos/zone', function(data){
    $('#todos').html(data);
    $('time.timeago').timeago();
  });
}

$(function(){ 
	$('.dialog-normal').dialog({ autoOpen: false, width: 700, dialogClass: 'shadow'});
  $('.dialog-popup').dialog({autoOpen:false, width:500, modal: true});
	$('ul.sf-menu').superfish(); 
  $('.date-picker').datepicker({ showButtonPanel: true, dateFormat: 'yy-mm-dd' });
  set_small_buttons();
  $('.barcode').barcode($('.barcode').text(), 'code128', {barHeight:20});
});

var test = 'ok';
