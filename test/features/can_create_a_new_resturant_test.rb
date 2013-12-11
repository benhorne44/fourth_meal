require_relative "../test_helper"

class CanCreateANewResturantTest < Capybara::Rails::TestCase
  test "can view restaurant registration page" do
    FactoryGirl.create(:user)
    visit login_path

    fill_in "Username", with: 'big_eater'
    fill_in "Password", with: 'password'

    within(".form-container") do
      click_on "Login"
    end

    click_on "I want to create a restaurant"

    assert_content page, "Create your own restaurant"
  end

  test "a restaurant can be created" do
    FactoryGirl.create(:user)
    visit login_path

    fill_in "Username", with: 'big_eater'
    fill_in "Password", with: 'password'

    within(".form-container") do
      click_on "Login"
    end

    click_on "I want to create a restaurant"

    fill_in "Restaurant Name", with: 'Toms Tavern'
    fill_in "Address", with: '123 Street Street'
    fill_in "Zipcode", with: '90210'
    click_on "Submit for approval"

    restaurant = Restaurant.last

    visit restaurant_path(restaurant)
    assert_content page, 'Toms Tavern'
  end
end
