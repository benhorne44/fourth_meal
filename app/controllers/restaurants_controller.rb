class RestaurantsController < ApplicationController


  def index
    @restaurants = Restaurant.published_and_active
  end

  def show
    @restaurant = Restaurant.find_by(id: params[:id])
    if @restaurant.nil?
      redirect_to root_path
    else
      @items = @restaurant.active_items

      unless @restaurant.active? && @restaurant.published?
        if current_user
          if @restaurant.owners.include?(current_user) or current_user.admin?
            render :show
          else
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      end
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
    redirect_to root_path unless @restaurant.owners.include?(current_user) || current_user.admin
  end

  def toggle
    @restaurant = Restaurant.find(params[:id])
    redirect_to root_path unless @restaurant.owners.include?(current_user) || current_user.admin
    @restaurant.active ? @restaurant.active = false : @restaurant.active = true
    @restaurant.save
    redirect_to restaurant_dashboard_path(@restaurant)
  end

  def publish
    @restaurant = Restaurant.find(params[:id])
    redirect_to root_path unless @restaurant.owners.include?(current_user) || current_user.admin
    @restaurant.published ? @restaurant.published = false : @restaurant.published = true
    @restaurant.save
    redirect_to restaurant_dashboard_path(@restaurant)
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
