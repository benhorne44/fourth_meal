require "./test/test_helper"

class CreateUserTest < Capybara::Rails::TestCase

  test "user can reach signup form from login page" do
    visit login_path
    click_on "Create an Account"
    assert_content page, "Become a New User"
  end

  test "a user is created" do 
    visit new_user_path
    fill_in "Username", with: "Bob"
    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "password"
    click_on "Create my account"
    save_and_open_page
    assert_content page, "User Bob created!"
  end

end
