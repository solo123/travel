class Operates::BusSeat < Operates::Base
  belongs_to :schedule_assignment
  belongs_to :order
end
