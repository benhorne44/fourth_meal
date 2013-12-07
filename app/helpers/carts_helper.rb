module CartsHelper

  def order_item_quantity(order, item)
    order_item = order.order_items.where(item_id: item.id)
    order_item.first.quantity
  end

  def order_item(order, item)
    order.order_items.where(item_id: item.id).first
  end

  def login_status
    if cookies[:guest_email]
      "Logged in as Guest"
    end
  end

end
