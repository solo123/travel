class Order < ActiveRecord::Base
	belongs_to :order_source, :polymorphic => true
	has_one :order_option
	has_one :order_customer
	has_one :order_operate
	has_one :order_price
	has_many :order_items

	accepts_nested_attributes_for :order_customer, :allow_destroy => true
	accepts_nested_attributes_for :order_option, :allow_destroy => true
	accepts_nested_attributes_for :order_operate, :allow_destroy => true
	accepts_nested_attributes_for :order_price, :allow_destroy => true
	accepts_nested_attributes_for :order_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes['num_adult'].blank? || attributes[:num_adult].to_i < 1 }

	def gen_order_number
	  "#{(created_at.year - 2000).to_s(36)[-1].chr}#{created_at.month.to_s(36)}#{created_at.day.to_s(36)}#{id.to_s[-4..100]}".upcase
	end
end
