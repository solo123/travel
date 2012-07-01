class Photo < ActiveRecord::Base
  belongs_to :photo_data, :polymorphic => true
end
