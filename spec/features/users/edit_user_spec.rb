require 'rails_helper'

describe 'Editing user: ' do

  it "is not valid with name blank, stays on page & shows error" do
    u = User.create! user_attributes
    sign_in u
    visit edit_user_path(u)
    fill_in "Name", with: ""
    click_button "Update Account"
    e(page).to have_text "errors"
  end

  it "is valid with correctly formatted name, redirects to show with flash" do
    u = User.create! user_attributes
    sign_in u
    visit edit_user_path(u)
    fill_in "Name", with: "Meow"
    click_button "Update Account"
    e(current_path).to eq user_path(u)
    e(page).to have_text "successfully"
  end

end
