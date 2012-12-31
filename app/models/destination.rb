class Destination < ActiveRecord::Base
  has_one :description, :as => :desc_data, :dependent => :destroy
  accepts_nested_attributes_for :description, :allow_destroy => true
  
  belongs_to :title_photo, :class_name => 'Photo'
  has_many :photos, :as => :photo_data, :dependent => :destroy
  belongs_to :city
  
  scope :visible, where(:status => 1)
  def status_text
    if self.status && self.status > 0
      'show'
    else
      'hide'
    end
  end
end
