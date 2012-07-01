class Payment < ActiveRecord::Base
  belongs_to :bill, :polymorphic => true
  has_one :from_agent, :class_name => 'Agent'
  has_one :to_agent, :class_name => 'Agent'
  has_one :from_employee, :class_name => 'Employee'
  has_one :to_employee, :class_name => 'Employee'
  
  belongs_to :pay_method, :polymorphic => true
  has_one :operator, :class_name => 'Employee'
end