require "./test/test_helper"

class CanAccessItemsTest < Capybara::Rails::TestCase

  test "can see all items for resturant" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    visit restaurant_path(restaurant)
    assert_content page, "Deviled Eggs"
    refute_content page, "Bread"
  end

  test "can see item category" do
    restaurant = FactoryGirl.create(:restaurant)
    category = Category.create(name: "Plates")
    item = restaurant.items.create({title: "Burger", description: "Loafy goodness", price: '1'})
    category.items << item
    visit restaurant_path(restaurant)
    assert_content page, "Burger"
    assert_content page, "Plates"
  end


  test "inactive items are not visible" do
    restaurant = FactoryGirl.create(:restaurant)
    @item = restaurant.items.create({title: "Burger", description: "Loafy goodness", price: '1', active: false})
    @item2 = restaurant.items.create({title: "Pita", description: "Loafy badness", price:'1', active: true})
    visit restaurant_path(restaurant)
    within("#items") do
      assert_content page, "Loafy badness"
      refute_content page, "Loafy goodness"
    end
  end

  test "can view individual item info" do
    restaurant = FactoryGirl.create(:restaurant)
    @item = restaurant.items.create({title: "Burger", description: "Loafy goodness", price: '1'})
    @item2 = restaurant.items.create({title: "Pita", description: "Loafy badness", price:'1'})
    visit restaurant_path(restaurant)
    within("#item_1") do
      click_on "#{@item.title}"
    end
    assert_content page, "$1.00"
    assert_content page, "Burger"
  end

end
