class Email < ActiveRecord::Base
  belongs_to :email_data, :polymorphic => :true
end
