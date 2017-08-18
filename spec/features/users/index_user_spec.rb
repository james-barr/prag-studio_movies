require 'rails_helper'

describe "Listing all users: " do

  it "lists all users" do
    u1 = User.create! user_attributes
    u2 = User.create! user_attributes2
    u3 = User.create! user_attributes3
    visit users_path
    e(page).to have_text "3 Users"
    e(page).to have_text u1.name
    e(page).to have_text u2.username
    e(page).to have_text u2.email
    e(page).to have_text u3.name
  end


end
