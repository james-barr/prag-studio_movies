require 'rails_helper'

describe "Destroying a user: " do

  it "destroys a user and redirects to user index" do
    u = User.create! user_attributes
    visit user_path(u)
    click_link "Delete Account"
    e(current_path).to eq users_path
    e(page).to have_text "deleted successfully"
  end


end
