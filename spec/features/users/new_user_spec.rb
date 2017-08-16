require 'rails_helper'

describe "New user creation: " do

  it "does not create new user with blank fields and displays errors" do
    visit signup_path
    click_button "Create Account"
    e(current_path).to eq users_path
    e(page).to have_text "errors"
  end

  it "creates a valid user, redirects, and flashes" do
    visit signup_path
    fill_in "Name", with: "X"
    fill_in "Email", with: "x@x"
    fill_in "Password", with: "xx"
    fill_in "Confirm Password", with: "xx"
    click_button "Create Account"
    e(current_path).to eq user_path(User.last)
    e(page).to have_text "signed up"
  end

end