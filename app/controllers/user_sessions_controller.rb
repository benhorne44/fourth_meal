class UserSessionsController < ApplicationController
  # after_action :clear_return_to, only: [:create]

  def new
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def create
    if login(params[:username], params[:password])
      order_ids = cookies[:order_ids].to_s.split(',')
      orders = Order.find_all(order_ids)
      orders.each do |order|
        order.user_id = current_user.id
        order.save
      end
      saved_orders = current_user.orders.where(status: "saved")
      saved_order_ids = saved_orders.map { |order| order.id }
      updated_order_ids = Order.update_orders(orders, saved_orders)
      cookies[:order_ids] = updated_order_ids.join(',')
      unset_guest
      flash.notice = "Successfully logged in as #{current_user.username}"
      if !cookies[:return_to].blank?
        redirect_to cookies[:return_to]
      else
        redirect_to user_path(current_user)
      end
    else
      flash.notice = "Login failed"
      redirect_to :back
    end
  end

  def destroy
    order_ids = cookies[:order_ids].to_s.split(',')
    orders = Order.find_all(order_ids)
    orders.each do |order|
      order.status = "saved"
      order.save
    end
    logout
    cookies.delete :order_ids
    flash.notice = "Logged out"
    unset_guest
    redirect_to root_path
  end

  def options
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def submit_guest
    cookies[:guest_email] = params[:email]
    redirect_to cookies[:return_to] ? cookies[:return_to] : root_path
  end

  def unset_guest
    cookies.delete :guest_email unless cookies[:guest_email].blank?
  end

  def clear_return_to
    cookies.delete :return_to
  end

end
