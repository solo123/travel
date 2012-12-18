class Photo < ActiveRecord::Base
  attr_accessible :pic
  has_attached_file :pic, :styles => { :large => '1000x1000>', :small => '300x300>', :thumb => '80x80#' }

  belongs_to :photo_data, :polymorphic => true
end
