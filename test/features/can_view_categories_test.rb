require "./test/test_helper"

class CanViewCategoriesTest < Capybara::Rails::TestCase

  test "can see all items by category" do
    restaurant = FactoryGirl.create(:restaurant)
    category = Category.create(name: "brunch")
    item = restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    category.items << item

    visit restaurant_path(restaurant)
    assert_content page, "Deviled Eggs"
    assert_content page, "brunch"
  end

  test "can click tag to see all items with that tag" do
    restaurant = FactoryGirl.create(:restaurant)
    category = Category.create(name: "brunch")
    category2 = Category.create(name: "plates")
    item = restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    item2 = restaurant.items.create(title: 'Ham Sandwich', description: 'Pretty basic', price: '2')
    category.items << item
    category2.items << item2

    visit restaurant_path(restaurant)

    assert_content page, "Ham Sandwich"

    within("#item_1") do
      click_on "brunch"
    end

    refute_content page, "Ham Sandwich"

  end

end
