require_relative "../test_helper"

class AddItemsToOrderTest < Capybara::Rails::TestCase
  test "a user can add a restaurant's item to their Order" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    click_on "Order"
    assert_content page, "Beans"
  end

  test "items in the Order are displayed by restaurant" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    restaurant2 = FactoryGirl.create(:restaurant, name: "Ben's Beans")
    restaurant2.items.create(title: "Waffles", price: 5, description: "Waffles waffles waffles!")
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    visit restaurant_path(restaurant2)
    within("#item_2") do
      click_on "Add to Order"
    end
    click_on "Order"
    within("#order_1") do
      assert_content page, "Will's Waffles"
      assert_content page, "Beans"
    end
    within("#order_2") do
      assert_content page, "Ben's Beans"
      assert_content page, "Waffles"
    end
  end

  test "an item that is already in the Order when added increases the quantity" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    click_on "Order"
    within("#order_1") do
      assert_equal find_field("order_item_quantity").value, "1"
    end
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    click_on "Order"
    within("#order_1") do
      assert_equal find_field("order_item_quantity").value, "2"
    end
  end

  test "a single order Order does not have the 'Checkout All' button" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    click_on "Order"
    refute_css('#checkout_all')
  end

  test "multiple order Order does have the 'Checkout All' button" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    restaurant2 = FactoryGirl.create(:restaurant, name: "Ben's Beans")
    restaurant2.items.create(title: "Waffles", price: 5, description: "Waffles waffles waffles!")
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    visit restaurant_path(restaurant2)
    within("#item_2") do
      click_on "Add to Order"
    end
    click_on "Order"
    assert_css('#checkout_all')
  end

end
