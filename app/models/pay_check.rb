class PayCheck < ActiveRecord::Base
  belongs_to :payment
  belongs_to :casher, :class_name => 'Employee'
end

