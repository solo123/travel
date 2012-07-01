class Spot < ActiveRecord::Base
  set_table_name 'tour_routes'
  has_one :description, :as => :desc_data, :dependent => :destroy
  accepts_nested_attributes_for :description, :allow_destroy => true
  
  belongs_to :tour
  belongs_to :destination
end
