require_relative "../test_helper"

class RestaurantOwnerCanEditItemsTest < Capybara::Rails::TestCase
  test "restaurant owner can add items from dashboard" do
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

    within("#employee_controls") do
      click_on "Add a New Item"
    end

    fill_in "Title", with: 'Burger'
    fill_in "Description", with: 'Tasty with cheese'
    fill_in "Price", with: 500
    click_on 'Add Item'

    within("#items") do
      assert_content page, "Burger"
      assert_content page, "Tasty with cheese"
      assert_content page, "$5.00"
    end
  end

  test "restaurant owner can edit items from dashboard" do
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

    within("#employee_controls") do
      click_on "Add a New Item"
    end

    fill_in "Title", with: 'Burger'
    fill_in "Description", with: 'Tasty with cheese'
    fill_in "Price", with: 5
    click_on 'Add Item'

    within("#item_1") do
      click_on "Edit Item"
    end

    fill_in "Title", with: 'Enchilada'
    click_on "Update item"


    within("#items") do
      assert_content page, "Enchilada"
      refute_content page, "Burger"
    end
  end

end
