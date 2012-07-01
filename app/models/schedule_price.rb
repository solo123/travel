class SchedulePrice < ActiveRecord::Base
  belongs_to :schedule
  
  def room_price(num)
  	[self.price1, self.price2, self.price3, self.price4][num.to_i - 1]
  end
end
