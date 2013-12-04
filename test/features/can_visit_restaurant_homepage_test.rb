require_relative "../test_helper"

class CanVisitRestaurantHomepageTest < Capybara::Rails::TestCase
  test "restaurant can be visited from main page" do
    FactoryGirl.create(:restaurant)
    FactoryGirl.create(:restaurant, name: "Ben's Beans")
    visit root_path
    assert_content page, "Restaurant Listings"
    within("#restaurant_1") do
      click_on "Visit"
    end

    assert_content page, "Will's Waffles"
    refute current_path == root_path

    visit root_path
    within("#restaurant_2") do
      click_on "Visit"
    end

    assert_content page, "Ben's Beans"
    refute current_path == root_path
  end
end
