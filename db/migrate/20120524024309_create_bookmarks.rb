class CreateBookmarks < ActiveRecord::Migration
  def change
  	create_table :bookmarks do |t|
  		t.string :title
  		t.string :url
  		t.integer :show_order, :default => 0
  		t.integer :status, :default => 0
  		t.timestamps
  	end
  end
end
