class UserMailer < ActionMailer::Base
  default from: "customer_service@retto.com"

  def welcome_email(user)
    @user = user
    @url = "platable.herokuapp.com/login"
    mail(to: @user.email, subject: "Welcome to Platable")
  end

  def order_email(user_email, order_id)
    @user = User.find_by(email: user_email)
    @order = Order.find(order_id)
    @items = @order.items
    @url = "/thanks/#{@order.obscure_identifier}"
    mail(to: user_email, subject: "Your Grub is Forthcoming!")
  end

  def multi_order_email(user_email, order_ids)
    @user = User.find_by(email: user_email)
    @orders = Order.find(order_ids)
    @total = @orders.inject(0){|total, order| total + order.subtotal}
    mail(to: user_email, subject: "Your Grub is Forthcoming!")
  end
end
