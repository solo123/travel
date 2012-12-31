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
function check_hold(hold_id){
  var cbs = 'input[type=checkbox][hold_id=' + hold_id + ']';
  $(cbs).prop('checked', !$(cbs).prop('checked'));
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

function order_after_updated(){
  reload_seat_table();
  reload_orders();
}
function order_after_created(){
  order_after_updated();
}
function reload_seat_table(){
  var api = $('.tabs').data('tabs');
  api.getCurrentPane().load(api.getCurrentTab().attr('href'));
}
function reload_orders(){
  $.get("/admin/schedules/"+ $('.s-id').text().trim() +"/orders",function(data){
    $('#.unseat_orders').html(data);
  });
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
	pane.find('input[type="checkbox"]:checked').each(function(){
    var seat = $(this).parent().parent();
    if(!seat.hasClass('hold') && !seat.hasClass('sold')) result += $(this).next().text() + ', '; 
  });
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
function refresh_customer(){
  var uid = parseInt($('#order_order_detail_attributes_user_info_id').val());
  if (uid > 0 ){
    $.getJSON('/admin/user_infos/' + uid, function(data){
      $('#order_order_detail_attributes_full_name').val(data.full_name);
      $('#order_order_detail_attributes_telephone').val(data.telephone);
      $('#order_order_detail_attributes_email').val(data.email);
      $('#order_order_detail_attributes_bill_address').val(data.address);
    });
  } else {
    $('#order_order_detail_attributes_full_name').val("");
    $('#order_order_detail_attributes_telephone').val("");
    $('#order_order_detail_attributes_email').val("");
    $('#order_order_detail_attributes_bill_address').val("");
  }
}
var order_room_template = 
"<tr><td><input name='order[order_items_attributes][000][num_adult]' size='2' type='text' value=''></td>" +
"<td><input name='order[order_items_attributes][000][num_child]' size='2' type='text' value=''></td>" +
"<td>amount:</td><td><a href='javascript:void(0)' class='delete_room'>Remove</a></td></tr>";

function add_room(){
  var new_id = new Date().getTime();
  var regexp = new RegExp("000", "g");
  $("#rooms")
    .append(order_room_template.replace(regexp, new_id));

  $('.delete_room').click(function(){
    $(this).parent().parent().remove();
  });
}
// auto-run commands
$(function(){
  tabs_load();
});


