// button commands
function hold(){
	if (validate_seats()){
		var msg = prompt("Please input hold message:", "");
		var tab = $('.ui-tabs-panel:not(.ui-tabs-hide)');
		tab.find('input[name=message1]').val(msg);
		tab.find('input[name=operate]').val('hold');
		tab.find('form').submit();
	}	
}

function release(){
	if (validate_hold_seats()) {
		if (confirm('Are you sure to RELEASE these seats?')){
		  var tab = $('.ui-tabs-panel:not(.ui-tabs-hide)');
			tab.find('input[name=operate]').val('release');
		  tab.find('form').submit();
		}
	}
}

function validate_seats(){
	var tab = $('.ui-tabs-panel:not(.ui-tabs-hide)');
	if (tab.find('input[type="checkbox"]:checked').length == 0){
		alert('Please select seats.');
		return false;
	}

	var result = '';
	tab.find('input[type="checkbox"]:checked').each(function(){ if(!$(this).parent().parent().hasClass('blnk')) result += $(this).next().text() + ', '; });
	if (result.length > 0) {
		alert('Seats: ' + result + 'been taken. Please check again.');
		return false;
	}

	return true;
}
function validate_hold_seats(){
	var tab = $('.ui-tabs-panel:not(.ui-tabs-hide)');
	if (tab.find('input[type="checkbox"]:checked').length == 0){
		alert('Please select hold seats.');
		return false;
	}

	var result = '';
	tab.find('input[type="checkbox"]:checked').each(function(){ if(!$(this).parent().parent().hasClass('hold')) result += $(this).next().text() + ', '; });
	if (result.length > 0) {
		alert('Seats: ' + result + ' not hold. Please check again.');
		return false;
	}

	result = tab.find('input[type="checkbox"]:checked').map(function(){ return $(this).next().text(); }).get().join(',');
	$('#seats').val(result);
	$('#assignment_id').val(tab.attr('id').substr(5));
	$('#release_seats_text').text(result);
	return true;
}

// auto-run commands
$(function(){
	var $tabs = $( "#tabs").tabs({
		tabTemplate: "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>",
			load: function(event, ui){
				$('.small-button').button({icons:{primary:'ui-icon-pencil'}}); 
			}
	});


	$( "#tabs span.ui-icon-close" ).live( "click", function() {
		var index = $( "li", $tabs ).index( $( this ).parent() );
		if (confirm('This bus assignment can delete only when seats are EMPTY. \nAre you sure do delete it?')){
			var ass_id = $(this).parent().find('a').text().split(':')[0];
			$.ajax({ url: location.href + '/schedule_assignments/' + ass_id, type: 'DELETE'});
		}
	});

});


