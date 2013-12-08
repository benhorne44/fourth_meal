module OrdersHelper

  def checkout_header
    if current_user 
      "Order for #{current_user.username}"
    else
      "Review Your Order"
    end
  end

end
