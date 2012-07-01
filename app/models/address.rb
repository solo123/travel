class Address < ActiveRecord::Base
  belongs_to :city
  belongs_to :address_data, :polymorphic => :true
end
