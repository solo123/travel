class Telephone < ActiveRecord::Base
  belongs_to :tel_number, :polymorphic => :true
end
