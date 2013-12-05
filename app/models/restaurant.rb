class Restaurant < ActiveRecord::Base
  has_many :items
  has_many :orders

  def find_or_create_new_order(order_ids)
    current_orders = Order.find(order_ids)
    found_order = orders & current_orders
    found_order[0] || self.orders.create
  end

end
