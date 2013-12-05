class CartsController < ApplicationController

  def index
    order_ids = cookies[:order_ids].to_s.split(',')
    @orders = Order.find(order_ids)
  end

end
