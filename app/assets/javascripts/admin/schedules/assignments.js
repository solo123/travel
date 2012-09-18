// button commands
function hold(){
	if (validate_seats()){
		var msg = prompt("Please input hold message:", "");
    if (msg) {
      var pane = $('.panes > div:visible');
      pane.find('input[name=message1]').val(msg);
      pane.find('input[name=operate]').val('hold');
      pane.find('form').submit();
    }
	}	
}

function release(){
	if (validate_hold_seats()) {
		if (confirm('Are you sure to RELEASE these seats?')){
      var pane = $('.panes > div:visible');
			pane.find('input[name=operate]').val('release');
		  pane.find('form').submit();
		}
	}
}

function order(){
  if (validate_order_seats()){
    $.ajax({
      type: "GET",
      url: "/admin/orders/new",
      dataType: 'script',
      data: 'assignment_id=' + get_current_assignment_id() + '&seats=' + get_selected_seats()
    });
  }
}

function get_current_assignment_id(){
	var pane = $('.panes > div:visible');
	return pane.find('div').attr('id').substring(5);
}
function get_selected_seats(){
	var pane = $('.panes > div:visible');
	var ss = pane.find('input[type="checkbox"]:checked').map(function(){return this.id.substring(3);}).get().join(',');
	return ss;
}

function validate_seats(){
  var pane = $('.panes > div:visible');
	if (pane.find('input[type="checkbox"]:checked').length == 0){
		alert('Please select seats.');
		return false;
	}

	var result = '';
	pane.find('input[type="checkbox"]:checked').each(function(){ if(!$(this).parent().parent().hasClass('blnk')) result += $(this).next().text() + ', '; });
	if (result.length > 0) {
		alert('Seats: ' + result + 'been taken. Please check again.');
		return false;
	}

	return true;
}
function validate_hold_seats(){
	var pane = $('.panes > div:visible');
	if (pane.find('input[type="checkbox"]:checked').length == 0){
		alert('Please select hold seats.');
		return false;
	}

	var result = '';
	pane.find('input[type="checkbox"]:checked').each(function(){ if(!$(this).parent().parent().hasClass('hold')) result += $(this).next().text() + ', '; });
	if (result.length > 0) {
		alert('Seats: ' + result + ' not hold. Please check again.');
		return false;
	}
	return true;
}

function validate_order_seats(){
  var pane = $('.panes > div:visible');
	if (pane.find('input[type="checkbox"]:checked').length == 0){
		alert('Please select seats.');
		return false;
	}

	var result = '';
	pane.find('input[type="checkbox"]:checked').each(function(){
    var pnode = $(this).parent().parent();
    if(pnode.hasClass('sold')) result += $(this).next().text() + ', '; 
  });
	if (result.length > 0) {
		alert('Seats: ' + result + ' already been order. \n\nPlease check again.');
		return false;
	}

	return true;
}

function tabs_load(){
	var len = $('div.panes > div').length - 1;
  $("ul.tabs").tabs("div.panes > div", {
    effect: 'fade',
	  initialIndex: len,
    onBeforeClick: function(event, i){
      var pane = this.getPanes().eq(i);
      pane.load(this.getTabs().eq(i).attr('href'));
    }
  });
}

function assign_seat(order_id){
  if (validate_seats()){
	  var pane = $('.panes > div:visible');
    pane.find('input[name=order_id]').val(order_id);
    pane.find('input[name=operate]').val('order_seats');
    pane.find('form').submit();
  }
}
// auto-run commands
$(function(){
  tabs_load();
});


