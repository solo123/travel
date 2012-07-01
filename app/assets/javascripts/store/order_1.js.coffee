#
#  Global variables:
#    tour_id, max_days, valid_days
#
pad = (number, len) -> ('00000000' + number).slice(-len)
date_to_string = (date) -> "#{date.getFullYear()}.#{pad(date.getMonth()+1, 2)}.#{pad(date.getDate(), 2)}"

order_now = () ->
  url = "#{tour_id}/order"
  dep = $('#departure_date').val()
  url += '?departure_date=' + dep if (dep.length > 0)
  window.location.href = url

add_room = () ->
  room = "
  <div class='room'>
    Room <span class='room_id'>?</span>#
    <select name='num'>
      <option value='1'>1</option>
      <option value='2'>2</option>
      <option value='3'>3</option>
      <option value='4'>4</option>
    </select> person.
    <a href='javascript:void(0)' class='btn_remove_room'>remove</a>
  </div>";
  $('#rooms').append(room)

refresh_room_num = () ->
  $('#rooms div.room > span.room_id').text((index, val) -> index + 2)

check_order = () ->
  departure = $('#departure').val()
  pickup = $('input:radio[name=pickup]:checked').val()
  rooms = ($('#rooms select').map () -> $(this).val()).get().join(',')
  $('#inp_rooms').val(rooms)
  if (departure.length < 6)
    alert('Please choose departure date.')
  else if (pickup == undefined) 
    alert('Please choose where to pickup.')
  else
    $('#btn_caculate').attr('disabled', 'disabled')
    $.post('order', {
      departure:departure, 
      pickup:pickup, 
      rooms:rooms
      }, (data) -> eval(data)
    )
    $('#btn_caculate').removeAttr('disabled')
    

check_show_days = (date) ->
  s = date_to_string(date)
  if (window.valid_days.indexOf(s) < 0)
    [0, '', null]
  else
    [1, '', s]

$ ->
  $('#departure').datepicker({
    numberOfMonths: 2
    showButtonPanel: false
    minDate: 0
    maxDate: window.max_days
    beforeShowDay: (date) => check_show_days(date)
  })

  $('#btn_add_room').click () -> 
    add_room()
    $('.btn_remove_room').click () -> 
      $(this).parent().remove()
      refresh_room_num()
    refresh_room_num()

  $('#btn_caculate').click () -> check_order()

