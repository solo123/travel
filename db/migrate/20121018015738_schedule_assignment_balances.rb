class ScheduleAssignmentBalances < ActiveRecord::Migration
  def change
    create_table :schedule_assignment_costs do |t|
      t.integer :schedule_assignment_id
      t.integer :cost_type
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0 
      t.integer :edit_by
      t.timestamps
    end
    create_table :schedule_assignment_balances do |t|
      t.integer :schedule_id
      t.integer :schedule_assignment_id
      t.decimal :income, :precision => 8, :scale => 2, :default => 0
      t.decimal :cost, :precision => 8, :scale => 2, :default => 0
      t.decimal :balance, :precision => 8, :scale => 2, :default => 0
      t.timestamps
    end
  end
end
