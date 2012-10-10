class Bus < ActiveRecord::Base
  after_initialize :init_seats

  def init_seats
    if new_record?
      self.seats = 57
      self.seats_per_row ||= 4
      self.passengeway ||= 2
    end
  end
end
