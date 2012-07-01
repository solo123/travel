class Voucher < ActiveRecord::Base
	belongs_to :refund_order, :class_name => 'Order'
	belongs_to :pre_voucher, :class_name => 'Voucher'
end
