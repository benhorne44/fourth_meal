require_relative "../test_helper"

class HandlingInProcessOrdersWhenLoggingInAndOutTest < Capybara::Rails::TestCase
  test "users order is marked as in progress on logout" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 500, description: "Beans, beans, beans!")
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    log_in
    click_on "Logout"
    order = Order.first
    assert_equal 'saved', order.status
  end

  test "after logout the cart is empty" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 500, description: "Beans, beans, beans!")
    restaurant2 = FactoryGirl.create(:restaurant)
    restaurant2.items.create(title: "Wooffles", price: 500, description: "Waffles, waffles, waffles!")
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    visit restaurant_path(restaurant2)
    within('#item_2') do
      click_on "Add to Order"
    end
    log_in
    click_on "Logout"
    click_on "Order"
    assert_content page, "Your Order is empty."
  end

  test "users orders are marked as in progress on logout" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 500, description: "Beans, beans, beans!")
    restaurant2 = FactoryGirl.create(:restaurant)
    restaurant2.items.create(title: "Wooffles", price: 500, description: "Waffles, waffles, waffles!")
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    visit restaurant_path(restaurant2)
    within('#item_2') do
      click_on "Add to Order"
    end
    log_in
    click_on "Logout"
    order = Order.first
    order2 = Order.last
    assert_equal 'saved', order2.status
    assert_equal 'saved', order.status
  end

  test "when a user logs in they can see the contents of their saved order" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 500, description: "Beans, beans, beans!")
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    log_in
    click_on "Logout"
    within('.controls') do
      click_on "Login"
    end
    fill_in "Username", with: 'Banjo Billy'
    fill_in "Password", with: 'password'
    within('#login_button') do
      click_button "checkout_login_button"
    end
    save_and_open_page
    within('.controls') do
      click_on "Order"
    end
    assert_content page, "Beans"
  end

  test "saved and current orders for the same item are updated correctly when user logs in" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 500, description: "Beans, beans, beans!")
    restaurant2 = FactoryGirl.create(:restaurant, name: "Ben's Beans")
    restaurant2.items.create(title: "Waffles", price: 500, description: "Waffles, waffles, waffles!")
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    within('#item_1') do
      click_on "Add to Order"
    end
    visit restaurant_path(restaurant2)
    within('#item_2') do
      click_on "Add to Order"
    end
    log_in
    click_on "Logout"
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    within('.controls') do
      click_on "Login"
    end
    fill_in "Username", with: 'Banjo Billy'
    fill_in "Password", with: 'password'
    within('#login_button') do
      click_button "checkout_login_button"
    end
    within('.controls') do
      click_on "Order"
    end
    within("#order_3") do
      assert_content page, "Will's Waffles"
      assert_content page, "Beans"
    end
    within("#order_2") do
      assert_content page, "Ben's Beans"
      assert_content page, "Waffles"
    end
    click_on "Logout"
    visit restaurant_path(restaurant)
    within('#item_1') do
      click_on "Add to Order"
    end
    visit restaurant_path(restaurant2)
    within('#item_2') do
      click_on "Add to Order"
    end
    within('.controls') do
      click_on "Login"
    end
    fill_in "Username", with: 'Banjo Billy'
    fill_in "Password", with: 'password'
    within('#login_button') do
      click_button "checkout_login_button"
    end
    assert_content page, "You have unpurchased items from a previous visit, your current order has been updated."
    within('.controls') do
      click_on "Order"
    end
  end

  def log_in
    # @user = User.new
    # @user.username = 'Banjo Billy'
    # @user.password = 'password'
    # @user.email = 'user@example.com'
    # @user.save

    visit root_path
    click_on "Login"
    click_on "Create an Account"

    fill_in "Username", with: 'Banjo Billy'
    fill_in "Password", with: 'password'
    fill_in "Email", with: 'example@example.com'
    click_button "Create my account"
  end
end
