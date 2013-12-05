class CartsController < ApplicationController

  def index
    cookies[:order_ids] ||= []
    @orders = [Order.find(cookies[:order_ids])]
  end

end
