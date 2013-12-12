class UserMailer < ActionMailer::Base
  default from: "customer_service@platable.com"

  def welcome_email(user)
    @user = user
    @url = "platable.herokuapp.com/login"
    mail(to: @user.email, subject: "Welcome to Platable")
  end

  def order_email(user_email, order)
    @order = order
    @items = order.items
    @url = "localhost:3000/#{order.obscure_identifier}"
    @order_details
    mail(to: user_email, subject: "Your Grub is Forthcoming!")
  end
end
