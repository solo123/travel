class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :payment_data_type
      t.string :payment_data_id
      t.decimal :balance_before, :precision => 8, :scale => 2, :default => 0
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.decimal :current_balance, :precision => 8, :scale => 2, :default => 0
      t.string  :pay_from_type
      t.integer :pay_from_id
      t.string  :account_id
      t.string  :pay_method_type
      t.integer :pay_method_id
      t.integer :operator_id
      t.timestamps
    end
    create_table :pay_cashes do |t|
      t.integer :payment_id
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.integer :casher_id
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :pay_checks do |t|
      t.integer :payment_id
      t.string :check_number
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.integer :casher_id
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
      t.integer :casher_id
      t.integer :finished_by_id
      t.datetime :finished_at
      t.integer :user_id
      t.integer :is_web, :default => 0
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :pay_vouchers do |t|
      t.integer :payment_id
      t.integer :voucher_id
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.integer :casher_id
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
    create_table :pay_companies do |t|
      t.integer :payment_id
      t.integer :company_id
      t.string :company_order_number
      t.integer :invoice_id
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.integer :confirm_by_id
      t.integer :confirm_at
      t.integer :finished_at
      t.integer :finished_by_id
      t.integer :status, :default => 0
      t.timestamps
    end      
    create_table :accounts do |t|
      t.string :owner_type
      t.integer :owner_id
      t.string :account_name
      t.string :account_brief
      t.decimal :balance, :precision => 8, :scale => 2, :default => 0
      t.integer :status, :default => 0
      t.timestamps
    end
	
  end
end
