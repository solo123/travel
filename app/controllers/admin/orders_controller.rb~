module Admin
  class OrdersController < ResourceController
  	create.after :after_created

  	def after_created
  		@object.order_number = @object.gen_order_number
  		@object.save
  	end
  end
end