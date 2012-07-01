class CompanyReceivable < ActiveRecord::Base
	belongs_to :payment
	belongs_to :company, :class_name => 'Agent'
	belongs_to :confirm_employee, :class_name => 'Employee'
	belongs_to :operator, :class_name => 'Employee'
end
