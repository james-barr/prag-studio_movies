require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without a name" do
    u = User.new name: ""
    u.v?
    e(u.errors[:name].any?).to eq true
  end

  it "is invalid without an email" do
    u = User.new email: ""
    u.v?
    e(u.errors[:email].any?).to eq true
  end

  it "is invalid with an improperly formatted email" do
    u = User.new email: "y"
    u.v?
    e(u.errors[:email].any?).to eq true
  end

  it "is valid with a properly formatted email" do
    u = User.new email: "x@g.com"
    u.v?
    e(u.errors[:email].any?).to eq false
  end

  it "does not require a password when updating" do
    u = User.create user_attributes
    u.password = ""
    e(u.v?).to eq true
  end

  it "automatically creates a pass_word digest upon adding the password" do
    u = User.new password: "xgm"
    u.v?
    e(u.password_digest).to be_present
  end

  it "is invalid if an email is not unique (case-insensitive)" do
    u = User.create! user_attributes email: "xc@g.com"
    u2 = User.new user_attributes(email: u.email.upcase)
    u2.v?
    e(u2.errors[:email].any?).to eq true
  end

  it "is valid with all required attributes" do
    u = User.new user_attributes
    u.v?
    e(u.errors.any?).to eq false
  end

  it "requires matching password / pw_confirm in order to create" do
    u = User.create! user_attributes password: "x", password_confirmation: "x"
    e(u.v?).to eq true
  end

  it "is invalid without a password" do
    u = User.new password: ""
    u.v?
    e(u.errors[:password].any?).to eq true
  end

  it "is invalid if pw_confirm is missing" do
    u = User.new password: "x", password_confirmation: ""
    u.v?
    e(u.errors[:password_confirmation].any?).to eq true
  end

  it "is invalid if pw / pw_confirm don't match" do
    u = User.new password: "x", password_confirmation: "xx"
    u.v?
    e(u.errors[:password_confirmation].any?).to eq true
  end

  it "is invalid without a username" do
    u = User.new username: ""
    u.v?
    e(u.errors[:username].any?).to eq true
  end

  it "is invalid with a repeating username (case-insensitive)" do
    user = [',', '1.1', ' ','meow 1', 'x .x']
    user.each do |u|
      u1 = User.new user_attributes username: u
      u1.v?
      e(u1.errors[:username].any?).to eq true
    end
  end

  it "is invalid with a username that doesn't follow format" do
    u1 = User.create! user_attributes
    u2 = User.new username: u1.username.upcase
    u2.v?
    e(u2.errors[:username].any?).to eq true
  end

  it "does not authenticate without a username / email" do
    u = User.create! user_attributes username: "xxx", password: "x", password_confirmation: "x"
    e(User.authenticate("", u.password)).not_to eq true
  end

  it "does not authenticate without a password" do
    u = User.create! user_attributes username: "xxx", password: "x", password_confirmation: "x"
    e(User.authenticate("xxx", "")).not_to eq true
  end

  it "does authenticate with a valid username / email and password combo" do
    u = User.create! user_attributes username: "xxx", password: "x", password_confirmation: "x"
    e(User.authenticate("xxx", "x")).to eq u
  end

end
