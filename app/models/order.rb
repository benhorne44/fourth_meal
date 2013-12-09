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

end
