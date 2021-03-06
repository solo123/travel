class ScheduleAssignment < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :bus, :class_name => 'Bus'
  belongs_to :driver, :class_name => 'Employee'
  belongs_to :driver_assistance, :class_name => 'Employee'
  belongs_to :tour_guide, :class_name => 'Employee'
  belongs_to :tour_guide_assistance, :class_name => 'Employee'

  has_many :seats, :class_name => 'BusSeat'
  has_many :bus_shifts

  after_create :add_shifts
  after_update :add_shifts
  before_destroy :del_shifts

  def total_seats
    if self.bus
      self.bus.seats
    else
      57
    end
  end

  private
  def add_shifts
    return unless self.changed? && self.schedule
    s = self.schedule
    if self.bus_id_changed?
      self.bus_shifts.delete_all
      s.departure_date.upto(s.return_date).each do |d|
        bs = BusShift.new(:bus_id => self.bus_id, :schedule_assignment_id => self.id, :date => d)
        bs.save
      end
    end
    unless (self.changed & %w(driver_id driver_assistance_id tour_guide_id tour_guide_assistance_id) ).empty?
      EmployeeShift.where(:schedule_assignment_id => self._id).delete_all
      rs = []
      rs << self.driver_id if self.driver_id
      rs << self.driver_assistance_id if self.driver_assistance_id
      rs << self.tour_guide_id if self.tour_guide_id
      rs << self.tour_guide_assistance_id if self.tour_guide_assistance_id
      unless rs.empty?
        s.departure_date.upto(s.return_date).each do |d|
          rs.each do |r|
            es = EmployeeShift.new(:schedule_assignment_id => self.id, :employee_id => r, :date => d )
            es.save
          end
        end
      end
    end
  end
  def del_shifts
    self.bus_shifts.delete_all
    EmployeeShift.where(:schedule_id => self.schedule_id).delete_all
  end

end
