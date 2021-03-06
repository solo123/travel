class CreateBus < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.string :name
      t.integer :company_id
      t.string :bus_type
      t.integer :seats
      t.integer :seats_per_row
      t.integer :passengeway
      t.string :unavailable_seats
      t.string :plate_number
      t.string :vin_number
      t.date :inspection_date
      t.integer :is_own
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :bus_shifts do |t|
      t.integer :bus_id
      t.integer :schedule_assignment_id
      t.date :date
    end
  end
end
