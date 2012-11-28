class OrderCustomer < ActiveRecord::Base
  belongs_to :order
  belongs_to :customer, :class_name => 'UserInfo'

  has_one :email_data
  has_one :tel_number
  has_one :address_data
end
