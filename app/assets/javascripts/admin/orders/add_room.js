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

