require_relative "../test_helper"

class OrderIsEmptyUponArrivalTest < Capybara::Rails::TestCase

  test "visiting Order upon arrival shows it is empty" do
    visit root_path
    click_on "Order"
    assert_content page, "Your Order is empty."
  end

end
