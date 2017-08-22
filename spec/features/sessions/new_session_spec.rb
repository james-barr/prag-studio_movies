 require 'rails_helper'

describe "New session creation: " do

  it "shows all required fields" do
    visit signin_path
    e(page).to have_field "Email or Username"
    e(page).to have_field "Password"
    e(page).to have_selector "input[type=submit]"
    e(page).to have_link "Sign Up", href: signup_path
    e(page).to have_xpath "//input[@required='required']"
  end

  it "does not authenticate with no username or email & flashes error" do
    u = User.create! user_attributes email: "x@a", password: "X", password_confirmation: "X"
    visit signin_path
    fill_in "Email or Username", with: ""
    fill_in "Password", with: "X"
    click_button "Sign In"
    e(current_path).to eq session_path
    e(page).to have_text "Error"
  end

  it "does not authenticate with no password & flashes error" do
    u = User.create! user_attributes email: "x@a", password: "X", password_confirmation: "X"
    visit signin_path
    fill_in "Email or Username", with: "x@a"
    fill_in "Password", with: ""
    click_button "Sign In"
    e(current_path).to eq session_path
    e(page).to have_text "Error"
  end

    it "authenticates with proper email login info, redirects, and shows a flash" do
      u = User.create! user_attributes email: "x@y", password: "x", password_confirmation: "x"
      sign_in(u)
      e(current_path).to eq user_path(u)
      e(page).to have_text "Welcome back"
      e(page).to have_link u.name
      e(page).not_to have_link "Sign In"
      e(page).not_to have_link "Sign Up"
    end

    it "authenticates with proper username login info, redirects, and shows a flash" do
      u = User.create! user_attributes username: "xxx", password: "x", password_confirmation: "x"
      visit signin_path
      fill_in "Email or Username", with: "xxx"
      fill_in "Password", with: "x"
      click_button "Sign In"
      e(current_path).to eq user_path(u)
      e(page).to have_text "Welcome back"
      e(page).to have_link u.name
      e(page).not_to have_link "Sign In"
      e(page).not_to have_link "Sign Up"
    end

end
