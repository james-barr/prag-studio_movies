require 'rails_helper'

describe "Destroying a user: " do

  before do
    @u = User.create! user_attributes admin: false
    sign_in @u
  end

  it "destroys a user and redirects to user index" do
    visit user_path(@u)
    click_link "Delete Account"
    e(current_path).to eq root_path
    e(page).to have_text "deleted successfully"
    e(page).to have_text "Sign In"
    e(page).to have_text "Sign Up"
    e(page).not_to have_text "Sign Out"
  end


end
