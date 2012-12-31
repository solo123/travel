class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :employee_id
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.integer :sign_in_count
      t.string :page_url
      t.string :host
      t.string :remote_host
      t.string :remote_addr
      t.string :controller
      t.string :action
      t.string :log_brief
      t.string :log_text
      t.integer :level, :default => 0
      t.timestamps
    end   
  end

end
