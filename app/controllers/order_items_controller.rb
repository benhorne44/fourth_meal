class OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find(params[:id])

    if order_item.update(order_item_params)
      redirect_to cart_path, notice: 'Your item was updated.'
    else
      redirect_to cart_path, alert: 'There was an error.'
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order = Order.find(order_item.order_id)
    order_item.destroy
    restaurant = order.restaurant
    order.destroy_if_empty
    redirect_to cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end

end
