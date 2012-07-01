class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :bill_type
      t.string :bill_id
      t.decimal :pay_before, :precision => 8, :scale => 2, :default => 0
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :pay_after, :precision => 8, :scale => 2, :default => 0
      t.string  :pay_from_type
      t.integer :pay_from_id
      t.string  :pay_to_type
      t.integer :pay_to_id
      t.string  :pay_method_type
      t.integer :pay_method_id
      t.integer :operator_id
      t.timestamps
    end
    create_table :pay_cashes do |t|
      t.integer :payment_id
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.integer :employee_id
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :pay_checks do |t|
      t.integer :payment_id
      t.string :check_number
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.integer :employee_id
      t.datetime :finished_at
      t.integer :finished_by_id
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :pay_credit_cards do |t|
      t.integer :payment_id
      t.string :full_name
      t.string :card_type
      t.string :card_number
      t.string :valid_date
      t.string :csc
      t.integer :address_id
      t.string :prof_code
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :service_fee, :precision => 8, :scale => 2, :default => 0
      t.decimal :total_amount, :precision => 8, :scale => 2, :default => 0
      t.integer :look_card_by_id
      t.datetime :look_card_at
      t.integer :finished_by_id
      t.datetime :finished_at
      t.integer :member_id
      t.integer :is_web, :default => 0
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :pay_vouchers do |t|
      t.integer :payment_id
      t.integer :voucher_id
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.integer :employee_id
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :vouchers do |t|
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :pay_amount, :precision => 8, :scale => 2, :default => 0
      t.string :ticket_bar_code
      t.integer :refund_order_id
      t.integer :operator_id
      t.date :expire_date
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :pay_agents do |t|
      t.integer :payment_id
      t.integer :order_id
      t.integer :agent_id
      t.integer :invoice_id
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :agent_discount, :precision => 8, :scale => 2, :default => 0
      t.decimal :additional_discount, :precision => 8, :scale => 2, :default => 0
      t.decimal :account_receivable, :precision => 8, :scale => 2, :default => 0
      t.integer :confirm_by_id
      t.integer :confirm_at
      t.integer :finished_at
      t.integer :finished_by_id
      t.string :agent_order_number
      t.integer :status, :default => 0
      t.timestamps
    end      
	
  end
end
