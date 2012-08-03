class ScheduleAssignment < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :bus, :class_name => 'Bus'
  belongs_to :driver, :class_name => 'Employee'
  belongs_to :driver_assistance, :class_name => 'Employee'
  belongs_to :tour_guide, :class_name => 'Employee'
  belongs_to :tour_guide_assistance, :class_name => 'Employee'

  has_many :seats, :class_name => 'BusSeat'
  has_many :bus_shifts

  after_create :add_bus_shifts
  after_update :add_bus_shifts
  before_destroy :del_bus_shifts

  def total_seats
    if self.bus
      self.bus.seats
    else
      57
    end
  end

  private
  def add_bus_shifts
    s = self.schedule
    if s && self.bus
      unless self.bus_shifts.empty? || self.bus_shifts.first.bus_id == self.bus_id
        self.bus_shifts.delete_all
      end
      if self.bus_shifts.empty?
        s.departure_date.upto(s.return_date).each do |d|
          bs = BusShift.new(:bus_id => self.bus_id, :schedule_assignment_id => self.id, :date => d)
          bs.save
        end
      end
    end
  end
  def del_bus_shifts
    self.bus_shifts.delete_all
  end

end
