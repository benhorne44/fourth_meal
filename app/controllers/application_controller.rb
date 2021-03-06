class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_admin
    if current_user
      unless current_user.admin
        redirect_to user_path(current_user)
      end
    end
  end

  def require_user_or_guest
    unless current_user || guest
      store_redirect_destination
      redirect_to login_options_path
    end
  end

  def guest
    cookies[:guest_email]
  end

  def remove_cookie_order_id(order)
    order_ids = cookies[:order_ids].split(',')
    order_ids.delete(order.id.to_s)
    cookies.delete :order_ids
    cookies[:order_ids] = order_ids.join(',')
  end

  def store_redirect_destination
    unless request.fullpath == login_url
      cookies[:return_to] = request.fullpath
    end
  end

end
