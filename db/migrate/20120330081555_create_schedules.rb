class CreateSchedules < ActiveRecord::Migration
  def change
		create_table :schedules do |t|
    	t.integer :tour_id
    	t.string :title
    	t.date :departure_date
    	t.date :return_date
      t.integer :book_customers
      t.integer :actual_customers
      t.integer :actual_rooms
    	t.integer :status, :default => 0
    	t.timestamps
    end
    create_table :schedule_assignments do |t|
      t.string :title
      t.integer :schedule_id
      t.integer :bus_id
      t.integer :driver_id
      t.integer :driver_assistance_id
      t.integer :tour_guide_id
      t.integer :tour_guide_assistance_id
      t.timestamps
    end
    create_table :schedule_prices do |t|
      t.integer :schedule_id
      t.decimal :price_adult, :precision => 8, :scale => 2
      t.decimal :price_child, :precision => 8, :scale => 2
      t.decimal :price1, :precision => 8, :scale => 2
      t.decimal :price2, :precision => 8, :scale => 2
      t.decimal :price3, :precision => 8, :scale => 2
      t.decimal :price4, :precision => 8, :scale => 2
      t.timestamps
    end
    create_table :bus_seats do |t|
      t.integer :schedule_assignment_id
      t.integer :seat_number
      t.integer :order_id
      t.string :message1
      t.string :message2
      t.string :state
      t.timestamps
    end  	
  end
end
