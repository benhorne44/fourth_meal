require 'pry'
class ItemsController < ApplicationController

  #before_action :require_login, except: [:index, :show, :add_to_order]
  #before_action :require_admin, except: [:index, :show, :add_to_order]

  def index
    redirect_to new_order_path unless cookies[:order_id]
    if params["Categories"]
      @category = Category.find(params["Categories"])
      @items = Item.active.find_all {|item| item.categories.include? @category}
    else
      @items = Item.active
    end
    @categories = Category.all
    if cookies[:order_id]
      @order = Order.find(cookies[:order_id])
    else
      @order = nil
    end
  end

  def new
    @item = Item.new
    @categories = Category.all
    @restaurant = Restaurant.find(params[:id])
    redirect_to root_path unless @restaurant.owners.include? current_user
  end

  def create
    @restaurant = Restaurant.find(params[:item][:restaurant_id])
    redirect_to root_path unless @restaurant.owners.include? current_user
    @item = Item.new(item_params)
    @item.save
    @item.update_categories(params[:item][:category])
    @restaurant.items << @item
    redirect_to restaurant_dashboard_path(@restaurant)
  end

  def show
    @item = Item.find(params[:id])
    if cookies[:order_id]
      @order = Order.find(cookies[:order_id])
    else
      @order = nil
    end
  end

  def edit
    @item = Item.find(params[:id])
    @restaurant = @item.restaurant
    @categories = Category.all
  end

  def update
    @item = Item.update(params[:id], item_params)
    @item.update_categories(params[:item][:category])
    redirect_to items_path
  end

  def add_to_order
    item = Item.find(params[:id])
    restaurant = item.restaurant
    order = restaurant.find_or_create_new_order(cookies[:order_ids])
    if current_user
      order.user_id = current_user.id
      order.save
    end
    # fail
    if cookies[:order_ids].blank?
      cookies[:order_ids] = order.id.to_s
    else
      order_ids = cookies[:order_ids]
      cookies.delete :order_ids
      cookies[:order_ids] = order_ids << ",#{order.id}"
    end

    if order.items.include? item
      order_item = OrderItem.where(order_id:order.id, item_id:item.id).first
      new_quantity = order_item.quantity + 1
      order_item.update(quantity: new_quantity)
    else
      order.items << item
    end
    flash.notice = item.title + " added to Order!"
    redirect_to restaurant_path(restaurant)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :active)
  end

end
