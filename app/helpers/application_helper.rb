module ApplicationHelper
  def flash_messages
	  [:notice, :alert, :error].map do |msg_type|
	    if flash[msg_type]
	      content_tag :div, flash[msg_type], :class => "flash #{msg_type}"
	    else
	      ''
	    end
	  end.join("\n").html_safe
  end
end
