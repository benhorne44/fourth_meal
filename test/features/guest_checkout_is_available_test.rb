require_relative "../test_helper"

class GuestCheckoutIsAvailableTest < Capybara::Rails::TestCase
  test "on checkout user is given option to checkout as guest" do
    restuarant = FactoryGirl.create(:restaurant)
    restuarant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restuarant)
    within("#item_1") do
      click_on "Add to Order"
    end

    visit cart_path
    within("#order_1") do
      click_on "Checkout"
    end
    assert_content page, "Checkout as Guest"
    assert_content page, "Login to Checkout"
  end

  test "guest can go to billing information page" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end

    visit cart_path
    refute_content page, "Logged in as Guest"
    within("#order_1") do
      click_on "Checkout"
    end
    click_on "Checkout as Guest"
    fill_in "Email", with: "user@example.com"
    click_on "Login as Guest"
    save_and_open_page
    assert_content page, "Logged in as Guest"
  end
end
