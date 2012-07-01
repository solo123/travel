class AgentInvoices < ActiveRecord::Migration
  def change
  	create_table :agent_invoices do |t|
  		t.integer :agent_id
  		t.decimal :amount, :precision => 8, :scale => 2, :default => 0
  		t.decimal :commission, :precision => 8, :scale => 2, :default => 0
  		t.decimal :net_total, :precision => 8, :scale => 2, :default => 0
  		t.decimal :paid, :precision => 8, :scale => 2, :default => 0
  		t.integer :creator
  		t.integer :updator
  		t.integer :status, :default => 0
  		t.timestamps
  	end
  end
end
