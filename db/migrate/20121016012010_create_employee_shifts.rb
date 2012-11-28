class CreateEmployeeShifts < ActiveRecord::Migration
  def change
    create_table :employee_shifts do |t|
      t.integer :employee_id
      t.integer :schedule_assignment_id
      t.date :date
    end
    
  end

  def down
  end
end
