require_relative "../test_helper"

class CartIsEmptyUponArrivalTest < Capybara::Rails::TestCase

  test "visiting cart upon arrival shows it is empty" do
    visit root_path
    click_on "Cart"
    save_and_open_page
    assert_content page, "Your cart is empty."
  end

end
