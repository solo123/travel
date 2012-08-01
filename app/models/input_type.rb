class InputType < ActiveRecord::Base
  attr_accessible :type_name, :type_text, :type_value, :status

  scope :get_list, lambda { |type_name| where(:type_name => type_name).where(:status => 1) unless type_name.strip.empty? }
end
