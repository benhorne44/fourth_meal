class OrdersController < ApplicationController
  before_action :require_login, except: [:new, :show, :checkout, :checkout_all]
  before_action :require_admin, only: [:index]

  def index
    @orders = Order.all
  end

  def new
    order = Order.create
    cookies[:order_id] = order.id
    redirect_to order
  end

  def show
    if cookies[:order_id]
      @order = Order.find(cookies[:order_id])
    elsif params[:id]
      @order = Order.find(params[:id])
    end
    @order_items = @order.order_items
  end

  def checkout
    if cookies[:order_ids].to_s.split(",").include? params[:id].to_s
      @order = Order.find(params[:id])
      @items = @order.items
    else
      flash.notice = "There was an error processing your request"
      redirect_to :back
    end
    # unless current_user
    #   flash.notice = "Login is required to checkout"
    #   redirect_to login_path
    # else
    #   current_user.associate_order(cookies[:order_id])
    #   @order = Order.where(user_id: current_user.id).last
    #   @items = @order.items
    # end
  end

  def checkout_all
    if cookies[:order_ids]
      order_ids = cookies[:order_ids].to_s.split(',')
      @orders = Order.find(order_ids)
      @total = @orders.inject(0) { |sum, order| sum += order.subtotal }
    else
      flash.notice = "There was an error processing your request"
      redirect_to :back
    end
  end

  def place_order
    current_user.change_order_to_completed
    flash.notice = "Your order is successfull"
    cookies.delete :order_id
    UserMailer.order_email(current_user, current_user.orders.last).deliver
    redirect_to user_path(current_user)
  end
end
