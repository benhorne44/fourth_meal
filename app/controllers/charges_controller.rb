class ChargesController < ApplicationController

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
      timestamp = Time.now
      @orders.each do |order| 
        order.update_status('Completed')
        if current_user
          order.obscure_identifier = Encryptor.obscure_details(current_user.email, timestamp)
        else
          order.obscure_identifier = Encryptor.obscure_details(cookies[:guest_email], timestamp)
        end
        order.save
      end
      flash.notice = "Your order is successfull"
      cookies.delete :order_ids
      cookies.delete :guest_email
      #UserMailer.order_email(current_user, current_user.orders.last).deliver
    end
    redirect_to root_path
  end

  def create
    # Amount in cents
    order_id = ([params[:id].to_s] & cookies[:order_ids].to_s.split(',')).first
    @order = Order.find(order_id)
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
      @order.update_status('Completed')
      if current_user
        @order.obscure_identifier = Encryptor.obscure_details(current_user.email, Time.now)
      else
        @order.obscure_identifier = Encryptor.obscure_details(cookies[:guest_email], Time.now)
      end
      @order.save
      flash.notice = "Your order is successful"
      remove_cookie_order_id(@order)
      # UserMailer.order_email(current_user, current_user.orders.last).deliver
    end
    redirect_to completed_order_path(@order.obscure_identifier)
  end

end
