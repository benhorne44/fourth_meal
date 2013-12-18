class CartsController < ApplicationController

  def index
    order_ids = cookies[:order_ids].to_s.split(',')
    @orders = Order.find_all(order_ids)
    @total = @orders.inject(0) { |sum, order| sum + order.subtotal }
  end

end
