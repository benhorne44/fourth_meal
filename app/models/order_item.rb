class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates_numericality_of :quantity, greater_than: 0, only_integer: true

  def subtotal
    item.price * quantity
  end

end
