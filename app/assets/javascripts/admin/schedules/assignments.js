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

// auto-run commands
$(function(){

  $("ul.tabs").tabs("div.panes > div", {
    effect: 'fade',
    onBeforeClick: function(event, i){
      var pane = this.getPanes().eq(i);
      pane.load(this.getTabs().eq(i).attr('href'));
    }
  });

/*
	$( "#tabs span.ui-icon-close" ).live( "click", function() {
		var index = $( "li", $tabs ).index( $( this ).parent() );
		if (confirm('This bus assignment can delete only when seats are EMPTY. \nAre you sure do delete it?')){
			var ass_id = $(this).parent().find('a').text().split(':')[0];
			$.ajax({ url: location.href + '/schedule_assignments/' + ass_id, type: 'DELETE'});
		}
	});
*/
});


