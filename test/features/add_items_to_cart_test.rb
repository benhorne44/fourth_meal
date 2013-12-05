require_relative "../test_helper"

class AddItemsToCartTest < Capybara::Rails::TestCase
  test "a user can add a restaurant's item to their cart" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    click_on "Cart"
    save_and_open_page
    assert_content page, "Beans"
  end
end
