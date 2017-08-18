require 'rails_helper'

describe "Showing a user: " do

  it "shows all of the user attributes" do
    u = User.create! user_attributes
    visit user_path(u)
    e(page).to have_text u.name
    e(page).to have_text u.email
    e(page).to have_text u.username
    e(page).to have_text present_user_created(u)
    e(page).to have_selector "p.profile_image"
  end

end
