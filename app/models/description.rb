class Description < ActiveRecord::Base
  belongs_to :desc_data, :polymorphic => true
end