class ScheduleAssignment < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :bus, :class_name => 'Bus'
  belongs_to :driver, :class_name => 'Employee'
  belongs_to :driver_assistance, :class_name => 'Employee'
  belongs_to :tour_guide, :class_name => 'Employee'
  belongs_to :tour_guide_assistance, :class_name => 'Employee'
  
  has_many :seats, :class_name => 'BusSeat'
  has_many :bus_shifts
  
  def total_seats
    if bus_id
      10
    else
      57
    end
  end
  def add_shift
    s = self.schedule
    if s && self.bus && self.bus_shifts.empty?
      s.departure_date.upto(s.return_date).each do |d|
        bs = BusShift.new(:bus_id => self.bus_id, :schedule_assignment_id => self.id, :date => d)
        bs.save
      end
    end
  end
  def del_shift
    BusShift.where(:schedule_assignment_id => self.id).delete_all
  end

end
