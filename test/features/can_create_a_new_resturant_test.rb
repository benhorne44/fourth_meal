require_relative "../test_helper"

class CanCreateANewResturantTest < Capybara::Rails::TestCase
  test "can view restaurant registration page" do
    FactoryGirl.create(:user)
    FactoryGirl.create(:role)
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
    FactoryGirl.create(:role)
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

  test "an unpublished restaurant is not displayed on the index" do
    FactoryGirl.create(:user)
    FactoryGirl.create(:role)
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

    visit root_path
    refute_content page, "Toms Tavern"
  end

  test "a published restaurant is displayed on the index" do
    FactoryGirl.create(:role)
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
    restaurant.published = true
    restaurant.active = true
    restaurant.save

    visit root_path
    assert_content page, "Toms Tavern"
  end

  test "a restaurant owner can see the restaurant dashboard" do
    FactoryGirl.create(:user)
    FactoryGirl.create(:role)
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

    assert_content page, "Your new restaurant has been submitted"
    assert_content page, "Toms Tavern Dashboard"
  end

  test "a logged in user who doesn't own a restaurant can't see a restaurant dashboard" do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:user, {username: 'bob', password: 'password', email: 'bob@bob.com'})
    FactoryGirl.create(:role)
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

    restaurant = Restaurant.first

    click_on "Logout"
    click_on "Login"

    fill_in "Username", with: 'bob'
    fill_in "Password", with: 'password'
    within(".form-container") do
      click_on "Login"
    end

    visit restaurant_dashboard_path(restaurant)
    refute_content page, "Toms Tavern Dashboard"
    assert_content page, "Restaurant Listings"

  end
end
