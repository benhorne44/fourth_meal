class Restaurant < ActiveRecord::Base
  has_many :items
  has_many :orders
  has_many :users, through: :restaurant_user_roles
  has_many :roles, through: :restaurant_user_roles
  has_many :restaurant_user_roles

  def find_or_create_new_order(order_ids)
    order_ids = order_ids.to_s.split(',')
    current_orders = [Order.find_all(order_ids)].flatten
    found_order = orders & current_orders
    found_order[0] || self.orders.create
  end

  def active_items
    items.where(active: true)
  end

  def self.published_and_active
    where(active: true).where(published: true)
  end

end
