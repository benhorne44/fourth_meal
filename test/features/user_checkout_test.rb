require "./test/test_helper"

class UserCheckoutTest < Capybara::Rails::TestCase
  test "user must login before checking out" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on 'Add to Order'
    end

    click_on "Order"

    within("#order_1") do
      click_on "Checkout"
    end

    within(".controls") do
      assert_content page, "Login"
    end
  end

  test "user can visit checkout after logging in" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    user = FactoryGirl.create(:user)
    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on 'Add to Order'
    end
    click_on "Login"

    fill_in "Username", with: 'big_eater'
    fill_in "Password", with: 'password'
    click_button "Login"

    visit root_path

    click_on "Order"

    within("#order_1") do
      click_on "Checkout"
    end

    assert_content page, "Beans"
  end

end
