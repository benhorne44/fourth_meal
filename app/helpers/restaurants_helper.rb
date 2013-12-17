module RestaurantsHelper

  def restaurant_status(restaurant)
    restaurant.active ? "Status: Active" : "Status: Inactive"
  end

  def toggle_restaurant_button(restaurant)
    text = restaurant.active ? "Deactivate" : "Activate"
    button_to text, toggle_restaurant_path(restaurant)
  end

  def publish_restaurant_button(restaurant)
    text = restaurant.published ? "Unpublish" : "Publish"
    if current_user.admin
      button_to text, publish_restaurant_path(restaurant)
    else
      nil
    end
  end
end
