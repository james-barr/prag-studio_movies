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

  it "has many reviews" do
    u = User.new user_attributes
    m1 = Movie.new movie_attributes
    m2 = Movie.new movie_attributes
    r1 = m1.reviews.new review_attributes
    r2 = m2.reviews.new review_attributes2
    r1.user = u
    r2.user = u
    r1.save!
    r2.save!
    e(u.reviews).to include r1
    e(u.reviews).to include r2
  end

  it "has many fav_movies" do
    u = User.create! user_attributes
    m = Movie.create! movie_attributes
    m2 = Movie.create! movie_attributes2
    l1 = m.favorites.create! user: u
    l2 = m2.favorites.create! user: u
    e(u.fav_movies.count).to eq 2
    e(u.fav_movies).to include m
    e(u.fav_movies).to include m2
  end

  it "returns users by name" do
    u1 = User.create! user_attributes name: "Alex"
    u2 = User.create! user_attributes2 name: "Al"
    e(User.by_name).to include u1
    e(User.by_name).to include u2
  end

  it "returns users that are not admins" do
    u1 = User.create! user_attributes admin: true
    u2 = User.create! user_attributes2 admin: false
    e(User.not_admins).not_to include u1
    e(User.not_admins).to include u2
  end

end
