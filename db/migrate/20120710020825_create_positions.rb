class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.integer :status

      t.timestamps
    end
  end
end
