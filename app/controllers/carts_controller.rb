require "pry"

class CartsController < ApplicationController

  def index
    @orders = [Order.find(cookies[:order_ids])]
    binding.pry
  end

end
