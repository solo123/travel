class PayCompany < ActiveRecord::Base
  belongs_to :payment
  belongs_to :company
  belongs_to :casher, :class_name => 'Employee'
  belongs_to :confirm_by, :class_name => 'Employee'
  belongs_to :finished_by, :class_name => 'Employee'
end

