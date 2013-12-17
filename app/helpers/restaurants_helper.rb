module RestaurantsHelper

  def restaurant_status(restaurant)
    restaurant.active ? "Status: Active" : "Status: Inactive"
  end

  def toggle_restaurant_button(restaurant)
    text = restaurant.active ? "Deactivate" : "Activate"
    button_to text, toggle_restaurant_path(restaurant)
  end
end
