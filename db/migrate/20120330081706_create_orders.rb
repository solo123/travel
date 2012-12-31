class CreateOrders < ActiveRecord::Migration
  def change
		create_table :orders do |t|
      t.string :order_number
      t.integer :schedule_id
      t.integer :schedule_assignment_id
      t.string :order_method
      t.datetime :completed_at
      t.integer :status
      t.timestamps
    end
    create_table :order_details do |t|
      t.integer :order_id
      t.string :pickup
      t.integer :user_info_id
      t.string :full_name
      t.string :telephone
      t.string :email
      t.string :bill_addresss
      t.integer :created_by
      t.integer :last_operator
      t.integer :last_payment
      t.string :notes
      t.timestamps
    end
    create_table :order_prices do |t|
      t.integer :order_id
      t.integer :num_rooms
      t.integer :num_adult
      t.integer :num_child
      t.integer :num_total
      t.decimal :total_amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :adjustment_amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :actual_amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :payment_amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :balance_amount, :precision => 8, :scale => 2, :default => 0
      t.timestamps
    end
    create_table :order_items do |t|
      t.integer :order_id
      t.string :room_number
      t.integer :num_adult, :default => 0
      t.integer :num_child, :default => 0
      t.integer :num_total, :default => 0
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.timestamps
    end
  end
end
