class CreateInfos < ActiveRecord::Migration
  def change
  	create_table :destinations do |t|
    	t.string :title
    	t.string :title_cn
    	t.integer :city_id
    	t.integer :title_photo_id
    	t.integer :status
    	t.timestamps
    end
    create_table :descriptions do |t|
    	t.string :desc_data_type
    	t.integer :desc_data_id
    	t.text :en
    	t.text :cn
    	t.timestamps
    end
    create_table :remarks do |t|
      t.string :notes_type
      t.integer :notes_id
      t.string :notes_text
      t.integer :employee_id
      t.integer :status, :default => 0
      t.timestamps
    end
    create_table :cities do |t|
      t.string :city
      t.string :state
      t.string :country
      t.integer :status, :default => 0
    end
    create_table :photos do |t|
      t.string :photo_data_type
      t.integer :photo_data_id
      t.string :photoset
      t.string :photo_s
      t.string :photo_t
      t.string :photo_m
      t.string :photo_b
      t.timestamps
    end

		create_table :tours do |t|
    	t.string :title
    	t.string :title_cn
    	t.integer :days, :default => 0
    	t.integer :tour_type, :default => 0
    	t.integer :title_photo_id
    	t.integer :status, :default => 0
    	t.timestamps
    end
    create_table :tour_routes do |t|
    	t.integer :tour_id
    	t.integer :destination_id
    	t.integer :visit_day
      t.integer :visit_order
    	t.integer :status, :default => 0
    	t.timestamps
    end
    create_table :tour_prices do |t|
      t.integer :tour_id
      t.decimal :price_adult, :precision => 8, :scale => 2
      t.decimal :price_child, :precision => 8, :scale => 2
      t.decimal :price1, :precision => 8, :scale => 2
      t.decimal :price2, :precision => 8, :scale => 2
      t.decimal :price3, :precision => 8, :scale => 2
      t.decimal :price4, :precision => 8, :scale => 2
      t.timestamps
    end
    create_table :tour_settings do |t|
      t.integer :tour_id
      t.integer :is_auto_gen, :default => 0
      t.string :weekly
      t.integer :has_seat_table, :default => 0
      t.integer :is_float_price, :default => 0
      t.integer :days_in_advance, :default => 0
      t.datetime :last_schedule_date
      t.timestamps
    end  

    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.string :meta_keywords
      t.string :meta_description
      t.integer :status, :default => 0
      t.timestamps
    end

    create_table :telephones do |t|
      t.string :tel_number_type
      t.integer :tel_number_id
      t.string :tel_type
      t.string :tel
      t.timestamps
    end
    create_table :emails do |t|
      t.string :email_data_type
      t.integer :email_data_id
      t.string :email_address
      t.timestamps
    end
    create_table :addresses do |t|
      t.string :address_data_type
      t.integer :address_data_id
      t.string :address1
      t.string :address2
      t.string :zipcode
      t.integer :city_id
      t.integer :usage_type
      t.timestamps
    end
    create_table :agents do |t|
    	t.string :short_name
    	t.string :company_name
    	t.integer :company_type
    	t.string :icon_url
    	t.string :website
    	t.integer :status, :default => 0
    	t.timestamps
    end
    create_table :agent_accounts do |t|
      t.integer :agent_id
      t.decimal :discount, :precision => 8, :scale => 2, :default => 0
      t.decimal :max_credit, :precision => 8, :scale => 2, :default => 0
      t.decimal :balance,  :precision => 8, :scale => 2, :default => 0
      t.timestamps
    end
    create_table :contacts do |t|
      t.integer :agent_id
      t.string :contact_name
      t.timestamps
    end
    create_table :user_infos do |t|
      t.string :user_data_type
    	t.integer :user_data_id
    	t.string :full_name
    	t.string :user_type
    	t.integer :user_level, :default => 0
      t.string :login_name
    	t.string :pin
    	t.integer :status, :default => 0
    	t.timestamps
    end

  end

end
