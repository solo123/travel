function hold(){
  if (validate_seats()){
    var msg = prompt("Please input hold message:", "");
    var tab = $('.ui-tabs-panel:not(.ui-tabs-hide)');
    tab.find('input[name=message1]').val(msg);
    tab.find('form').submit();
  }	
}
 
