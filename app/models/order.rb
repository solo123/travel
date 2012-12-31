class Order < ActiveRecord::Base
  #after_save :save_seats

  attr_accessor :seats

  belongs_to :schedule
  belongs_to :schedule_assignment
  has_one :order_detail
  has_one :order_price
  has_many :order_items
  has_many :payments, :as => :payment_data

  accepts_nested_attributes_for :order_detail, :allow_destroy => true
  accepts_nested_attributes_for :order_price, :allow_destroy => true
  accepts_nested_attributes_for :order_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes['num_adult'].blank? || attributes[:num_adult].to_i < 1 }

  after_create :gen_order_number

  def gen_order_number
    self.order_number = "#{(created_at.year - 2000).to_s(36)[-1].chr}#{created_at.month.to_s(36)}#{created_at.day.to_s(36)}#{('%04d' % id).to_s[-4..-1]}".upcase
    self.save
  end

  def seats
    @seats ||= get_seats
  end

  def save_seats
    return unless self.schedule_assignment
    unless @seats
      BusSeat.where(:order_id => self.id).delete_all
      return
    end
    @seats = eval('[' + @seats + ']') if @seats.class.name == 'String'
    BusSeat.where(:order_id => self.id).delete_all
    o_seats = get_seats
    (@seats - o_seats).each do |s|
        bs = BusSeat.new
        bs.order_id = self.id
        bs.seat_number = s
        bs.schedule_assignment_id = self.schedule_assignment_id
        bs.save
    end
  end
  def get_seats
    if self.schedule_assignment
      self.schedule_assignment.seats.where(:order_id => self.id).map {|ass| ass.seat_number}
    else
      nil
    end
  end
  def recaculate_price
    return unless self.schedule
    self.build_order_price unless self.order_price
    self.order_items.each do |item|
      item.num_total = item.num_adult + item.num_child
      if item.num_total > 0 && item.num_total <= 4
        item.amount = eval("self.schedule.price.price#{item.num_total}")
      end
      item.save
    end
    op = self.order_price
    op.num_rooms = self.order_items.count
    op.num_total = self.order_items.sum(:num_total)
    op.total_amount = self.order_items.sum(:amount)
    op.actual_amount = op.total_amount + op.adjustment_amount
    op.balance_amount = op.total_amount + op.adjustment_amount - op.payment_amount
    op.save
  end
end
