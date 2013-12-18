class OrderItem < ActiveRecord::Base
  belongs_to :order, :touch => true
  belongs_to :item, :touch => true

  validates_numericality_of :quantity, greater_than: 0, only_integer: true

  def subtotal
    item.price * quantity
  end

end
