class OrderDetail < ActiveRecord::Base
	belongs_to :order
  belongs_to :user_info
	belongs_to :creator, :class_name => 'Employee', :foreign_key => 'created_by'
	belongs_to :last_operator, :class_name => 'Employee', :foreign_key => 'last_operator'
	belongs_to :last_payment, :class_name => 'Employee', :foreign_key => 'last_payment'
end


