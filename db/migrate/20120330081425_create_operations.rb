class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :operate_type
      t.integer :operate_id
      t.integer :employee_id
      t.string :method
      t.string :title
      t.string :detail
      t.timestamps
    end
    create_table :ads do |t|
      t.string :flickr_photo_id
      t.string :image_url
      t.string :info
      t.string :url
      t.string :image_type
      t.integer :status, :default => 0
      t.timestamps
    end
        
  end

end
