class PayCash < ActiveRecord::Base
  belongs_to :payment
  belongs_to :casher, :class_name => 'Employee'
  belongs_to :user
end

