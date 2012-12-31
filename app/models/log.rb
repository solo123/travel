class Log < ActiveRecord::Base
  belongs_to :employee

  def self.last_operations(employee)
    self.where(:employee_id => employee.id).order('created_at desc').limit(5)
  end
end
