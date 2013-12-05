require_relative "../test_helper"

class CartIsEmptyUponArrivalTest < Capybara::Rails::TestCase
 
  test "visiting cart upon arrival shows it is empty" do
    visit root_path
    click_on "My Order"
    save_and_open_page
    assert_content page, "Sorry, Brah"
  end

end
