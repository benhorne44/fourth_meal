require_relative "../test_helper"

class RestaurantsHaveTheirOwnsItemsTest < Capybara::Rails::TestCase
  test "restaurants have items" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    restaurant.items.create(title: "Waffles", price: 7, description: "Waffles waffles waffles!")
    visit root_path
    within("#restaurant_1") do
      click_on "Visit"
    end
    within("#item_1") do
      assert_content page, "Beans"
    end
    within("#item_2") do
      assert_content page, "Waffles"
    end
  end

  test "restaurants have different items" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant2 = FactoryGirl.create(:restaurant, name: "Ben's Beans")
    restaurant.items.create(title: "Beans", price: 5, description: "Beans beans beans!")
    restaurant2.items.create(title: "Waffles", price: 7, description: "Waffles waffles waffles!")
    visit root_path
    within("#restaurant_1") do
      click_on "Visit"
    end
    within("#items") do
      refute_content page, "Waffles"
      within("#item_1") do
        assert_content page, "Beans"
      end
    end

    visit root_path
    within("#restaurant_2") do
      click_on "Visit"
    end
    within("#items") do
      refute_content page, "Beans"
      within("#item_2") do
        assert_content page, "Waffles"
      end
    end
  end
end
