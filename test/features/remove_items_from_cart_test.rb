require_relative "../test_helper"

class RemoveItemsFromCartTest < Capybara::Rails::TestCase
  
  test "an item can be removed from the cart" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on "Add to Order"
    end
    assert_content page, "Beans"

    click_on "Cart"
    within("#item_1") do
      click_on "Remove"
    end

    refute_content page, "Beans"
  end

  test "an item's quantity being changed to zero caused it to be removed from cart" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on "Add to Order"
    end
    assert_content page, "Beans"

    click_on "Cart"
    within("#item_1") do
      fill_in "Quantity", with: 0
      click_on "Update Quantity"
    end
    refute_content page, "Beans"
  end

end
