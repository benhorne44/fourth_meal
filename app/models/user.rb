class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_format_of :email, :with => /@/
  has_many :orders
  has_many :roles, through: :jobs
  has_many :restaurants, through: :jobs
  has_many :jobs

  def associate_order(order_id)
    orders << Order.find(order_id)
  end

  def change_order_to_completed
    orders.last.update_status("completed")
  end

  def recent_orders
    orders.where(status: 'Completed')
  end

  def restaurant_owner
    jobs.map(&:role_id).include?(1)
  end

end
