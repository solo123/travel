class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences, :force => true do |t|

      t.string :key
      t.string :value_type

      t.string :name
      t.integer :owner_id
      t.string :owner_type
      t.integer :group_id
      t.string :group_type
      t.text   :value

      t.timestamps
    end

    add_index :preferences, :key, :unique => true
  end

end
