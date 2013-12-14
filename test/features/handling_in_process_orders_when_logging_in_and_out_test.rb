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
    within('.controls') do
      click_on "Order"
    end
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
    click_on "Order"
    assert_content page, "Beans"
  end

  def log_in
    @user = User.new
    @user.username = 'Banjo Billy'
    @user.password = 'password'
    @user.email = 'user@example.com'
    @user.save

    visit root_path
    click_on "Login"
    click_on "Create an Account"

    fill_in "Username", with: @user.username
    fill_in "Password", with: @user.password
    fill_in "Email", with: @user.email
    click_button "Create my account"
  end
end
