require 'rails_helper'

describe "Signing a user: " do

  it "redirects to their intended url" do
    u = User.create! user_attributes username: "xxx", password: "x", password_confirmation: "x"
    visit users_url
    e(current_path).to eq signin_path
    sign_in u
    e(current_path).to eq users_path
  end

end
