class ChargesController < ApplicationController
  def new
    @order = current_user.orders.last
    @amount = @order.subtotal * 100
  end

  def multiple_new
    order_ids = cookies[:order_ids].to_s.split(',')
    @orders = Order.find(order_ids)
    @total = @orders.inject(0) { |total, order| total + order.subtotal}
  end

  def charges_all
    order_ids = cookies[:order_ids].to_s.split(',')
    @orders = Order.find(order_ids)
    @total = @orders.inject(0) { |total, order| total + order.subtotal} * 100


    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )
    begin
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @total.to_i,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
    else
      @orders.each {|order| order.update_status('Completed')}
      flash.notice = "Your order is successfull"
      cookies.delete :order_ids
      #UserMailer.order_email(current_user, current_user.orders.last).deliver
    end
    redirect_to root_path
  end

  def create
    # Amount in cents
    @order = current_user.orders.last
    @amount = @order.subtotal * 100

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )
    begin
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount.to_i,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
    else
      current_user.change_order_to_completed
      flash.notice = "Your order is successfull"
      cookies.delete :order_id
      UserMailer.order_email(current_user, current_user.orders.last).deliver
    end
    redirect_to user_path(current_user)
  end

end
