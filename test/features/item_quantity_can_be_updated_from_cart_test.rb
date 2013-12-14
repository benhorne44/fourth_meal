require_relative "../test_helper"

class ItemQuantityCanBeUpdatedFromOrderTest < Capybara::Rails::TestCase

  test "an item's quantity being changed another number causes the quantity to be updated" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on "Add to Order"
    end
    assert_content page, "Beans"

    within('.controls') do
      click_on "Order"
    end
    within("#item_1") do
      fill_in "order_item_quantity", with: 10
      click_on "Update Quantity"
    end
    within("#item_1") do
      assert_equal find_field("order_item_quantity").value, "10"
    end
  end

end
