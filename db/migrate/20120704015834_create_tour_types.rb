class CreateTourTypes < ActiveRecord::Migration
  def change
    create_table :tour_types do |t|
      t.string :type_name
      t.integer :status

      t.timestamps
    end
  end
end
