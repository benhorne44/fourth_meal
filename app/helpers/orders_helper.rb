module OrdersHelper

  def checkout_header
    if current_user 
      "ORDER FOR '#{current_user.username.upcase}'"
    else
      "REVIEW YOUR ORDER"
    end
  end

end
