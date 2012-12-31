class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.string :short_name
    	t.string :company_name
    	t.string :company_type
    	t.string :icon_url
    	t.string :website
    	t.integer :status, :default => 0
    	t.timestamps
    end
    create_table :company_accounts do |t|
      t.integer :company_id
      t.decimal :discount, :precision => 8, :scale => 2, :default => 0
      t.decimal :max_credit, :precision => 8, :scale => 2, :default => 0
      t.decimal :balance,  :precision => 8, :scale => 2, :default => 0
      t.timestamps
    end
    create_table :contacts do |t|
      t.integer :company_id
      t.string :contact_name
      t.timestamps
    end
   end

end
