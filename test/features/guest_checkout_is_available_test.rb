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

    assert_content page, "Guest Checkout"
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
    within("#order_1") do
      click_on "Checkout"
    end

    within("#guest-checkout") do
      fill_in "Email", with: "user@example.com"
    end
    click_on "Continue as Guest"

    assert_content page, "Will's Waffles"
  end
end
