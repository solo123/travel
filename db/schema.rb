# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120712064107) do

  create_table "addresses", :force => true do |t|
    t.string   "address_data_type"
    t.integer  "address_data_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "zipcode"
    t.integer  "city_id"
    t.integer  "usage_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "ads", :force => true do |t|
    t.string   "flickr_photo_id"
    t.string   "image_url"
    t.string   "info"
    t.string   "url"
    t.string   "image_type"
    t.integer  "status",          :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "agent_accounts", :force => true do |t|
    t.integer  "agent_id"
    t.decimal  "discount",   :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "max_credit", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "balance",    :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "agent_invoices", :force => true do |t|
    t.integer  "agent_id"
    t.decimal  "amount",     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "commission", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "net_total",  :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "paid",       :precision => 8, :scale => 2, :default => 0.0
    t.integer  "creator"
    t.integer  "updator"
    t.integer  "status",                                   :default => 0
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "agents", :force => true do |t|
    t.string   "short_name"
    t.string   "company_name"
    t.integer  "company_type"
    t.string   "icon_url"
    t.string   "website"
    t.integer  "status",       :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "bookmarks", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "show_order", :default => 0
    t.integer  "status",     :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "bus_seats", :force => true do |t|
    t.integer  "schedule_assignment_id"
    t.integer  "seat_number"
    t.integer  "order_id"
    t.string   "message1"
    t.string   "message2"
    t.string   "state"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "bus_shifts", :force => true do |t|
    t.integer "bus_id"
    t.integer "schedule_assignment_id"
    t.date    "date"
  end

  create_table "buses", :force => true do |t|
    t.string   "name"
    t.string   "bus_type"
    t.integer  "seats"
    t.integer  "seats_per_row"
    t.integer  "passengeway"
    t.string   "unavailable_seats"
    t.string   "plate_number"
    t.string   "vin_number"
    t.date     "inspection_date"
    t.integer  "is_own"
    t.integer  "status",            :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "cities", :force => true do |t|
    t.string  "city"
    t.string  "state"
    t.string  "country"
    t.integer "status",  :default => 0
  end

  create_table "contacts", :force => true do |t|
    t.integer  "agent_id"
    t.string   "contact_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "descriptions", :force => true do |t|
    t.string   "desc_data_type"
    t.integer  "desc_data_id"
    t.text     "en"
    t.text     "cn"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "destinations", :force => true do |t|
    t.string   "title"
    t.string   "title_cn"
    t.integer  "city_id"
    t.integer  "title_photo_id"
    t.integer  "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "email_data_type"
    t.integer  "email_data_id"
    t.string   "email_address"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "employee_infos", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "agent_id"
    t.integer  "user_info_id"
    t.string   "nickname"
    t.date     "employ_date"
    t.string   "ssn"
    t.string   "pin"
    t.date     "birthday"
    t.integer  "status",       :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "login_name",                             :null => false
    t.string   "email"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "employees", ["login_name"], :name => "index_employees_on_login_name", :unique => true
  add_index "employees", ["reset_password_token"], :name => "index_employees_on_reset_password_token", :unique => true

  create_table "input_types", :force => true do |t|
    t.string   "type_name"
    t.string   "type_text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "operations", :force => true do |t|
    t.string   "operate_type"
    t.integer  "operate_id"
    t.integer  "employee_id"
    t.string   "method"
    t.string   "title"
    t.string   "detail"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "order_customers", :force => true do |t|
    t.integer  "order_id"
    t.integer  "customer_id"
    t.string   "full_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.string   "room_number"
    t.integer  "num_adult",                                 :default => 0
    t.integer  "num_child",                                 :default => 0
    t.integer  "num_total",                                 :default => 0
    t.decimal  "amount",      :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "order_operates", :force => true do |t|
    t.integer  "order_id"
    t.integer  "created_by"
    t.integer  "last_operator"
    t.integer  "last_payment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "order_options", :force => true do |t|
    t.integer  "order_id"
    t.string   "pickup"
    t.integer  "bill_address_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "order_prices", :force => true do |t|
    t.integer  "order_id"
    t.integer  "num_rooms"
    t.integer  "num_adult"
    t.integer  "num_child"
    t.integer  "num_total"
    t.decimal  "total_amount",      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "adjustment_amount", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "actual_amount",     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "payment_amount",    :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "balance_amount",    :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "order_number"
    t.string   "order_source_type"
    t.integer  "order_source_id"
    t.string   "order_method"
    t.datetime "completed_at"
    t.integer  "status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.integer  "status",           :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "pay_agents", :force => true do |t|
    t.integer  "payment_id"
    t.integer  "order_id"
    t.integer  "agent_id"
    t.integer  "invoice_id"
    t.decimal  "amount",              :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "agent_discount",      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "additional_discount", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "account_receivable",  :precision => 8, :scale => 2, :default => 0.0
    t.integer  "confirm_by_id"
    t.integer  "confirm_at"
    t.integer  "finished_at"
    t.integer  "finished_by_id"
    t.string   "agent_order_number"
    t.integer  "status",                                            :default => 0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  create_table "pay_cashes", :force => true do |t|
    t.integer  "payment_id"
    t.decimal  "amount",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "employee_id"
    t.integer  "status",                                    :default => 0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "pay_checks", :force => true do |t|
    t.integer  "payment_id"
    t.string   "check_number"
    t.decimal  "amount",         :precision => 8, :scale => 2, :default => 0.0
    t.integer  "employee_id"
    t.datetime "finished_at"
    t.integer  "finished_by_id"
    t.integer  "status",                                       :default => 0
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

  create_table "pay_credit_cards", :force => true do |t|
    t.integer  "payment_id"
    t.string   "full_name"
    t.string   "card_type"
    t.string   "card_number"
    t.string   "valid_date"
    t.string   "csc"
    t.integer  "address_id"
    t.string   "prof_code"
    t.decimal  "amount",          :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "service_fee",     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "total_amount",    :precision => 8, :scale => 2, :default => 0.0
    t.integer  "look_card_by_id"
    t.datetime "look_card_at"
    t.integer  "finished_by_id"
    t.datetime "finished_at"
    t.integer  "member_id"
    t.integer  "is_web",                                        :default => 0
    t.integer  "status",                                        :default => 0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "pay_vouchers", :force => true do |t|
    t.integer  "payment_id"
    t.integer  "voucher_id"
    t.decimal  "amount",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "employee_id"
    t.integer  "status",                                    :default => 0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "bill_type"
    t.string   "bill_id"
    t.decimal  "pay_before",      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "amount",          :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "pay_after",       :precision => 8, :scale => 2, :default => 0.0
    t.string   "pay_from_type"
    t.integer  "pay_from_id"
    t.string   "pay_to_type"
    t.integer  "pay_to_id"
    t.string   "pay_method_type"
    t.integer  "pay_method_id"
    t.integer  "operator_id"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "photo_data_type"
    t.integer  "photo_data_id"
    t.string   "photoset"
    t.string   "photo_s"
    t.string   "photo_t"
    t.string   "photo_m"
    t.string   "photo_b"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "title"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "preferences", :force => true do |t|
    t.string   "key"
    t.string   "value_type"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "group_id"
    t.string   "group_type"
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "preferences", ["key"], :name => "index_preferences_on_key", :unique => true

  create_table "remarks", :force => true do |t|
    t.string   "notes_type"
    t.integer  "notes_id"
    t.string   "notes_text"
    t.integer  "employee_id"
    t.integer  "status",      :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "schedule_assignments", :force => true do |t|
    t.string   "title"
    t.integer  "schedule_id"
    t.integer  "bus_id"
    t.integer  "driver_id"
    t.integer  "driver_assistance_id"
    t.integer  "tour_guide_id"
    t.integer  "tour_guide_assistance_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "schedule_prices", :force => true do |t|
    t.integer  "schedule_id"
    t.decimal  "price_adult", :precision => 8, :scale => 2
    t.decimal  "price_child", :precision => 8, :scale => 2
    t.decimal  "price1",      :precision => 8, :scale => 2
    t.decimal  "price2",      :precision => 8, :scale => 2
    t.decimal  "price3",      :precision => 8, :scale => 2
    t.decimal  "price4",      :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "tour_id"
    t.string   "title"
    t.date     "departure_date"
    t.date     "return_date"
    t.integer  "book_customers"
    t.integer  "actual_customers"
    t.integer  "actual_rooms"
    t.integer  "status",           :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "telephones", :force => true do |t|
    t.string   "tel_number_type"
    t.integer  "tel_number_id"
    t.string   "tel_type"
    t.string   "tel"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "tour_prices", :force => true do |t|
    t.integer  "tour_id"
    t.decimal  "price_adult", :precision => 8, :scale => 2
    t.decimal  "price_child", :precision => 8, :scale => 2
    t.decimal  "price1",      :precision => 8, :scale => 2
    t.decimal  "price2",      :precision => 8, :scale => 2
    t.decimal  "price3",      :precision => 8, :scale => 2
    t.decimal  "price4",      :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "tour_routes", :force => true do |t|
    t.integer  "tour_id"
    t.integer  "destination_id"
    t.integer  "visit_day"
    t.integer  "visit_order"
    t.integer  "status",         :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tour_settings", :force => true do |t|
    t.integer  "tour_id"
    t.integer  "is_auto_gen",        :default => 0
    t.string   "weekly"
    t.integer  "has_seat_table",     :default => 0
    t.integer  "is_float_price",     :default => 0
    t.integer  "days_in_advance",    :default => 0
    t.datetime "last_schedule_date"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "tour_types", :force => true do |t|
    t.string   "type_name"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tours", :force => true do |t|
    t.string   "title"
    t.string   "title_cn"
    t.integer  "days",           :default => 0
    t.integer  "tour_type",      :default => 0
    t.integer  "title_photo_id"
    t.integer  "status",         :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "user_infos", :force => true do |t|
    t.string   "user_data_type"
    t.integer  "user_data_id"
    t.string   "full_name"
    t.string   "user_type"
    t.integer  "user_level",     :default => 0
    t.string   "login_name"
    t.string   "pin"
    t.integer  "status",         :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vouchers", :force => true do |t|
    t.decimal  "amount",          :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "pay_amount",      :precision => 8, :scale => 2, :default => 0.0
    t.string   "ticket_bar_code"
    t.integer  "refund_order_id"
    t.integer  "operator_id"
    t.date     "expire_date"
    t.integer  "status",                                        :default => 0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

end
