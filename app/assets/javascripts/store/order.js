var schedule_prices = [0,0,0,0];

  function pad(number, len) {
    return ('00000000' + number).slice(-len);
  }

  function date_to_string(date) {
    return "" + (date.getFullYear()) + "." + (pad(date.getMonth() + 1, 2)) + "." + (pad(date.getDate(), 2));
  }

  function order_now() {
    var dep, url;
    url = "" + tour_id + "/order";
    dep = $('#departure_date').val();
    if (dep.length > 0) url += '?departure_date=' + dep;
    window.location.href = url;
  }

  function refresh_rooms() {
    var rooms_num = parseInt($('#rooms_num').val());
    var num = $('.a_room').length;
    if(num < rooms_num){
      for(var i=num+1; i<=rooms_num; i++){
        var room = "<div class='a_room'>Room " + i + ":" +
          " Adult " +
          "<select name='adult_num[]'>" + 
          "  <option value='1'>1</option>" +
          "  <option value='2'>2</option>" +
          "  <option value='3'>3</option>" +
          "  <option value='4'>4</option>" +
          "</select>" +
          " Child " +
          "<select name='child_num[]'>" + 
          "  <option value='0'>0</option>" +
          "  <option value='1'>1</option>" +
          "  <option value='2'>2</option>" +
          "  <option value='3'>3</option>" +
          "</select> " +
          "<span class='price'></span>" +
          "</div>";
        $('#rooms').append(room);    
      }
    } else if (num > rooms_num){
      for(var i=num; i>rooms_num; i--){
        $('.a_room:last-child').remove();
      }
    }
    $('.a_room select').change(function(){
      check_rooms();
    });
  }

  function check_rooms(){
    $('.a_room').each(function(){
      var adult = $(this).find('select:first').val();
      var child = $(this).find('select:last').val();
      var total = parseInt(adult) + parseInt(child);
      if (total>4){
        if (! $(this).hasClass('error'))
          $(this).addClass('error').append('<span class="error">Above 4 person per room not allowed.</span>');
      }
      else {
        if ($(this).hasClass('error'))
          $(this).removeClass('error').find('span.error').remove();
        $(this).find('span.price').html('$' + schedule_prices[total]);
      }
    });
  }



  function check_order() {
    var departure, pickup, rooms;
    departure = $('#departure').val();
    pickup = $('input:radio[name=pickup]:checked').val();
    rooms = ($('#rooms select').map(function() {
      return $(this).val();
    })).get().join(',');
    $('#inp_rooms').val(rooms);
    if (departure.length < 6) {
      return alert('Please choose departure date.');
    } else if (pickup === void 0) {
      return alert('Please choose where to pickup.');
    } else {
      $('#btn_caculate').attr('disabled', 'disabled');
      $.post('order', {
        departure: departure,
        pickup: pickup,
        rooms: rooms
      }, function(data) {
        return eval(data);
      });
      return $('#btn_caculate').removeAttr('disabled');
    }
  }

  function check_show_days(date) {
    var s;
    s = date_to_string(date);
    if (window.valid_days.indexOf(s) < 0) {
      return [0, '', null];
    } else {
      return [1, '', s];
    }
  }

  function refresh_prices(){
    var tour_id = $('#tour_id').val();
    var departure_date = $('#departure').val();
    if (departure_date.length > 0){
      $.get("/tours/" + tour_id + "/prices", {departure: departure_date});  
    }
  }

  $(function() {
    refresh_rooms();
    refresh_prices();
    $('#departure').datepicker({
      numberOfMonths: 2,
      showButtonPanel: false,
      minDate: 0,
      maxDate: window.max_days,
      beforeShowDay: function(date) {
        return check_show_days(date);
      },
      onSelect: function(dateText, inst) {
        refresh_prices();
      }
    });
    $('#rooms_num').change(function(){
      refresh_rooms();
    });
    $('#btn_caculate').click(function() {
      return check_order();
    });
    
  });
