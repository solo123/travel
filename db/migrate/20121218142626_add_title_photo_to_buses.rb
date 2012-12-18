class AddTitlePhotoToBuses < ActiveRecord::Migration
  def change
    add_column :buses, :title_photo_id, :integer
  end
end
