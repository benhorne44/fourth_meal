require './test/test_helper'
require 'pry'
class CanPlaceOrderTest < Capybara::Rails::TestCase

  test "can add an item to the current order" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    assert_content page, "Deviled Eggs added to Order!"
  end

  test "cannot set the quantity to a negative number" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end

    visit cart_path
    fill_in 'order_item_quantity', with: '-5'
    click_on 'Update Quantity'

    assert_content page, 'There was an error.'
    assert_equal "1", find_field('order_item_quantity').value
  end


  test "can add multiple items to order without logging in" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    restaurant.items.create(title: 'Hard Boiled Eggs', description: '12 hard eggs', price: '1')
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    within("#item_2") do
      click_on "Add to Order"
    end

    click_on "Order"
    within("#item_1") do
      assert_content page, "Deviled Eggs"
    end
    within("#item_2") do
      assert_content page, "Hard Boiled Eggs"
    end
  end

  test "can add multiple instances of same item to order" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    restaurant.items.create(title: 'Hard Boiled Eggs', description: '12 hard eggs', price: '1')

    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    within("#item_1") do
      click_on "Add to Order"
    end

    click_on "Order"
    within("#item_1") do
      assert_equal "2", find_field('order_item_quantity').value
    end
  end

  test "user can adjust items in Order" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    restaurant.items.create(title: 'Hard Boiled Eggs', description: '12 hard eggs', price: '1')

    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    within("#item_1") do
      click_on "Add to Order"
    end

    click_on 'Order'

    within("#item_1") do
      fill_in "order_item_quantity", with: 10
      click_on "Update Quantity"
    end

    within("#item_1") do
      assert_equal "10", find_field('order_item_quantity').value
    end
  end


end
