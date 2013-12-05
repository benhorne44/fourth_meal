
# require "pry"
require_relative "../test_helper"

class CanCheckoutFromSiteTest < Capybara::Rails::TestCase

  test "taken correctly to checkout page" do
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
    click_on "Cart"
    within("#order_1") do
      click_on "Checkout"
    end
    save_and_open_page
    assert_content page, "Review Your Order"
    within('#order_details') do
      assert_content page, "Beans"
      assert_content page, "Will's Waffles"
    end
  end

  def log_in
    user = User.new
    user.username = 'user'
    user.password = 'password'
    user.email = 'user@example.com'
    user.save

    visit root_path

    click_on "Login"

    fill_in "Username", with: 'user'
    fill_in "Password", with: 'password'
    click_button "Login"
  end

end
