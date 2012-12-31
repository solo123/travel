class Payment < ActiveRecord::Base
  belongs_to :payment_data, :polymorphic => true
  belongs_to :pay_from, :polymorphic => true
  belongs_to :pay_to, :polymorphic => true
  belongs_to :pay_method, :polymorphic => true
  belongs_to :operator, :class_name => 'Employee'
  belongs_to :account

end
