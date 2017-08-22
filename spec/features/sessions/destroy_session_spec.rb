require 'rails_helper'

describe "Destroying a session (sign out): " do

  it "signs out, destroys the session, redirects, and flashes" do
    u = User.create! user_attributes
    sign_in u
    click_link "Sign Out"
    e(current_path).to eq root_path
    e(page).to have_text "You have signed out"
    e(page).to have_text "Sign In"
    e(page).to have_text "Sign Up"
    e(page).not_to have_text "Sign Out"
  end

end
