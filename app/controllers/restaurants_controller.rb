class RestaurantsController < ApplicationController


  def index
    @restaurants = Restaurant.published_and_active
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.active_items

    unless (@restaurant.active? && @restaurant.published?) ||
      (@restaurant.owners.include?(current_user)) ||
      current_user.admin?

      redirect_to root_path
    end
  end

  def new
    unless current_user
      cookies[:return_to] = request.fullpath
      redirect_to_login
    end
    @restaurant = Restaurant.new
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      flash.notice = "Your new restaurant has been submitted"
      Job.create_new(restaurant, current_user, 'owner')
      redirect_to restaurant_dashboard_path(restaurant)
    else
      flash.notice = "There was an error"
      redirect_to :back
    end
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items
    redirect_to root_path unless @restaurant.owners.include? current_user
  end

  private

  def redirect_to_login
    flash.notice = "Login is required to create a restaurant"
    redirect_to login_path
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :zipcode)
  end

end
