class BusShift < ActiveRecord::Base
  attr_accessible :bus_id, :date, :schedule_assignment_id
end
