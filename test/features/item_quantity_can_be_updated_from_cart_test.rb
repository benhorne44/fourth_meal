require_relative "../test_helper"

class ItemQuantityCanBeUpdatedFromCartTest < Capybara::Rails::TestCase

  test "an item's quantity being changed another number causes the quantity to be updated" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on "Add to Order"
    end
    assert_content page, "Beans"

    click_on "Cart"
    within("#item_1") do
      fill_in "Quantity", with: 10
      click_on "Update Quantity"
    end
    within("#item_1") do
      assert_equal find_field("Quantity").value, "10"
    end
  end

end
