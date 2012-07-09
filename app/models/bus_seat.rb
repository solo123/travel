class BusSeat < ActiveRecord::Base
  belongs_to :schedule_assignment
  belongs_to :order
end
