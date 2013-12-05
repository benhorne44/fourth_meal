require "./test/test_helper"

class ReturnToHomepageViaMainLogoTest < Capybara::Rails::TestCase

  test "homepage can be returned to from a restaurant page" do
    restaurant = FactoryGirl.create(:restaurant)
    visit restaurant_path(restaurant)
    within("#main_logo") do
      click_on "retto"
    end
    assert current_path == root_path
  end

end
