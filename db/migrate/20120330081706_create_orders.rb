class CreateOrders < ActiveRecord::Migration
  def change
		create_table :orders do |t|
      t.string :order_number
      t.string :order_source_type
      t.integer :order_source_id
      t.string :order_method
      t.datetime :completed_at
      t.integer :status
      t.timestamps
    end
    create_table :order_options do |t|
      t.integer :order_id
      t.string :pickup
      t.integer :bill_address_id
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
    create_table :order_operates do |t|
      t.integer :order_id
      t.integer :created_by
      t.integer :last_operator
      t.integer :last_payment
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
    create_table :order_customers do |t|
      t.integer  :order_id
      t.integer  :customer_id
      t.string   :full_name
      t.timestamps
    end  	
  end
end
