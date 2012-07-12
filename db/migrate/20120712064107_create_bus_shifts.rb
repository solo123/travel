class CreateBusShifts < ActiveRecord::Migration
  def change
    create_table :bus_shifts do |t|
      t.integer :bus_id
      t.integer :schedule_assignment_id
      t.date :date
    end
  end
end
