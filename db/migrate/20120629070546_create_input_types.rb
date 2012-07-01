class CreateInputTypes < ActiveRecord::Migration
  def change
    create_table :input_types do |t|
      t.string :type_name
      t.string :type_text

      t.timestamps
    end
  end
end
