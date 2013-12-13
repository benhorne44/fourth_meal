module ApplicationHelper

  def print_price(price)
    number_to_currency(price/100.00)
  end

  def login_status
    if current_user
      "Logged in as #{current_user.username}"
    end
  end

  def cart_items_total
    if cookies[:order_ids]
      order_ids = cookies[:order_ids].split(',')
      orders = Order.find_all(order_ids)
      orders.inject(0) do |total, order|
        total += order.order_items.inject(0) { |sum, order_item| sum + order_item.quantity }
      end
    else
      0
    end
  end

end

