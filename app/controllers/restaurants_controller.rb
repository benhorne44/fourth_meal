class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items
  end

end
