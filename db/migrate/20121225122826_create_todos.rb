class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.integer :msg_from
      t.integer :msg_to
      t.string :message
      t.integer :level
      t.integer :status
      t.datetime :due_date
      t.timestamps
    end
  end
end
