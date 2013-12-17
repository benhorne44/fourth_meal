require_relative "../test_helper"

class CanCheckoutFromSiteTest < Capybara::Rails::TestCase

  test "guest is taken correctly to checkout page for individual restaurant" do
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
    guest_login
    within('.controls') do
      click_on "Order"
    end
    within("#order_1") do
      click_on "Checkout"
    end
    assert_content page, "Review Your Order"

    within('#order_details') do
      assert_content page, "Beans"
      assert_content page, "Will's Waffles"
    end
  end

  test "logged in user is taken correctly to checkout page for individual restaurant" do
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
    log_in
    within('.controls') do
      click_on "Order"
    end
    within("#order_1") do
      click_on "Checkout"
    end
    assert_content page, "Order for #{@user.username}"

    within('#order_details') do
      assert_content page, "Beans"
      assert_content page, "Will's Waffles"
    end
  end

  test "guest is taken correctly to checkout page for checkout all" do
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
    guest_login
    within('.controls') do
      click_on "Order"
    end
    click_on "Checkout All"
    assert_content page, "Review Your Order"
    within("#restaurant_1_order") do
      assert_content page, "Beans"
      assert_content page, "Will's Waffles"
    end

    within("#restaurant_2_order") do
      assert_content page, "Waffles"
      assert_content page, "Ben's Beans"
    end
  end

  test "logged in user is taken correctly to checkout page for checkout all" do
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
    log_in
    within('.controls') do
      click_on "Order"
    end
    click_on "Checkout All"
    assert_content page, "Order for #{@user.username}"
    within("#restaurant_1_order") do
      assert_content page, "Beans"
      assert_content page, "Will's Waffles"
    end

    within("#restaurant_2_order") do
      assert_content page, "Waffles"
      assert_content page, "Ben's Beans"
    end
  end

  test "checkout all page displays order total for all restaurants" do
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
    guest_login
    within('.controls') do
      click_on "Order"
    end
    click_on "Checkout All"
     within("#all_orders_total") do
      assert_content page, "$10.00"
    end
  end

  test "checkout page displays username" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")

    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "Add to Order"
    end
    log_in
    visit root_path
    within('.controls') do
      click_on "Order"
    end
    assert_content page, "Logged in as #{@user.username}"
  end

  def log_in
    @user = User.new
    @user.username = 'Banjo Billy'
    @user.crypted_password = 'password'
    @user.email = 'user@example.com'
    @user.save

    visit root_path
    click_on "Login"
    click_on "Create an Account"

    fill_in "Username", with: @user.username
    fill_in "Password", with: @user.crypted_password
    fill_in "Email", with: @user.email
    click_button "Create my account"
  end

  def guest_login
    visit login_options_path
    within("#guest-checkout") do
      fill_in "email", with: 'someone@example.com'
    end
    click_button "Continue as Guest"
    save_and_open_page
  end

end
