class Restaurant < ActiveRecord::Base
  has_many :items
  has_many :orders

  def find_or_create_new_order(order_ids)
    order_ids = order_ids.to_s.split(',')
    current_orders = [Order.find_all(order_ids)].flatten
    found_order = orders & current_orders
    found_order[0] || self.orders.create
  end

end
