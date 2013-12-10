require_relative "../test_helper"

class RemoveItemsFromOrderTest < Capybara::Rails::TestCase
  
  test "an item can be removed from the Order" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on "Add to Order"
    end
    assert_content page, "Beans"

    click_on "Order"
    within("#item_1") do
      click_on "Remove"
    end

    refute_content page, "Beans"
  end

end
