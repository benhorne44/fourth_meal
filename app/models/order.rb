class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user
  belongs_to :restaurant

  def self.pending
    where(status: "pending")
  end

  def self.find_or_create_new(id)
    if id
      Order.find(id)
    else
      Order.new
    end
  end

  def self.find_all(order_ids)
    where(id: order_ids)
  end

  def destroy_if_empty
    self.destroy if order_items.empty?
  end

  def total_items
    order_items.inject(0) do |sum, order_item|
      sum + order_item.quantity
    end
  end

  def update_status(new_status)
    Order.update(self.id, status: new_status)
  end

  def subtotal
    order_items.inject(0) do |sum, order_item|
      item_price = Item.find(order_item.item_id).price
      sum + order_item.quantity * item_price
    end
  end

  def self.update_orders(new_orders, old_orders)
    # find any pairs of orders for same restaurant
    # add old order deets to new order
    # return new order id
    new_orders.each do |order|
      matched_order = old_orders.select { |o| o.restaurant_id == order.restaurant_id }
      if matched_order.first
        matched_order.first.order_items.each do |order_item|
          if order.items.include? order_item.item
            found_order_item = OrderItem.where(order_id:order.id, item_id:order_item.item.id).first
            new_quantity = found_order_item.quantity + order_item.quantity
            found_order_item.update(quantity: new_quantity)
          else
            order.items << order_item.item
          end
        end
        old_orders = old_orders - matched_order
        matched_order.first.status = "pending"
        matched_order.first.save
      end
      order.save
    end
    (new_orders + old_orders).map { |ord| ord.id }
  end

end
