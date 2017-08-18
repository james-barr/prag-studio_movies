require 'rails_helper'

describe "New session creation: " do

  it "shows all required fields" do
    visit signin_path
    e(page).to have_field "Email"
    e(page).to have_field "Password"
    e(page).to have_selector "input[type=submit]"
    e(page).to have_link "Sign Up", href: signup_path
    e(page).to have_xpath "//input[@required='required']"
  end

end
