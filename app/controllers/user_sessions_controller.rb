class UserSessionsController < ApplicationController

  def new
  end

  def create
    if login(params[:username], params[:password])
      unset_guest
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
    redirect_to items_path
  end

  def options
  end

  def submit_guest
    cookies[:guest_email] = params[:email]
    redirect_to cart_path
  end

  def unset_guest
    cookies.delete :guest_email unless cookies[:guest_email].blank?
  end
end
