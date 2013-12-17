class OrdersController < ApplicationController
  before_action :require_login, except: [:new, :show, :checkout, :checkout_all, :completed_order]
  before_action :require_admin, only: [:index]
  before_action :require_user_or_guest, only: [:checkout, :checkout_all]

  def index
    @orders = Order.all
  end

  def new
    order = Order.create
    cookies[:order_id] = order.id
    redirect_to order
  end

  # def show
  #   if cookies[:order_id]
  #     @order = Order.find(cookies[:order_id])
  #   elsif params[:id]
  #     @order = Order.find(params[:id])
  #   end
  #   @order_items = @order.order_items
  # end

  def checkout
    if cookies[:order_ids].to_s.split(",").include? params[:id].to_s
      @order = Order.find_by(id: params[:id])
      @items = @order.items
    else
      flash.notice = "There was an error processing your request"
      redirect_to :back
    end
  end

  def checkout_all
    if cookies[:order_ids]
      order_ids = cookies[:order_ids].to_s.split(',')
      @orders = Order.find_all(order_ids)
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

  def completed_order
    @orders = Order.where(obscure_identifier: params[:id])
  end
end
