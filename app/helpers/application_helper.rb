module ApplicationHelper

  def print_price(price)
    number_to_currency price
  end

  def login_status
    if current_user
      "Logged in as #{current_user.username}"
    end
  end

end

