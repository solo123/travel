$(function(){
	// Variables
	var objMain = $('#page_main');

	// Show sidebar
	function showSidebar(){
		objMain.addClass('use-sidebar');
		$.cookie('sidebar-pref2', 'use-sidebar', { expires: 30 });
    load_logs();
    load_todos();
	}

	// Hide sidebar
	function hideSidebar(){
		objMain.removeClass('use-sidebar');
		$.cookie('sidebar-pref2', null, { expires: 30 });
	}

	// Sidebar separator
	var objSeparator = $('#separator');

	objSeparator.click(function(e){
		e.preventDefault();
		if ( objMain.hasClass('use-sidebar') ){
			hideSidebar();
		}
		else {
			showSidebar();
		}
	}).css('height', objSeparator.parent().outerHeight() + 'px');

	// Load preference
	if ( $.cookie('sidebar-pref2') == null ){
		objMain.removeClass('use-sidebar');
	}

  if (objMain.hasClass('use-sidebar')){
    load_todos();
    load_logs();
  }


});
