require "pry"
class UserSessionsController < ApplicationController

  def new
  end

  def create
    if login(params[:username], params[:password])
      flash.notice = "Successfully logged in as #{current_user.username}"
      redirect_to items_path
    else
      flash.notice = "Login failed"
      redirect_to login_path
    end
  end

  def destroy
    logout
    flash.notice = "Logged out"
    redirect_to root_path
  end

  def options
  end

  def guest
  end

  def submit_guest
    cookies[:guest_email] = params[:email]
    redirect_to cart_path
  end

  def login_to_checkout
    if login(params[:username], params[:password])
      flash.notice = "Successfully logged in as #{current_user.username}"
      redirect_to cookies[:return_to]
    else
      flash.notice = "Login failed"
      redirect_to login_path
    end
  end
end
