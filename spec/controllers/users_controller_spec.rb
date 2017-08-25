require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @u = User.create! user_attributes
  end

  context "when logged out" do

    before(:each) do
      session[:user_id] = nil
    end

    it "won't allow access to user index" do
      get :index
      e(response).to redirect_to signin_url
    end

    it "won't allow access to user show" do
      get :show, params: { id: @u }
      e(response).to redirect_to signin_url
    end

    it "won't allow access to user edit" do
      get :edit, params: { id: @u }
      e(response).to redirect_to signin_url
    end

    it "won't allow access to user delete" do
      delete :destroy, params: { id: @u }
      e(response).to redirect_to signin_url
    end

    it "won't allow access to user update" do
      patch :update, params: { id: @u }
      e(response).to redirect_to signin_url
    end

  end

  context "when logged in as a wrong user" do

    before(:each) do
      @wrong_user = User.create! user_attributes2 email: "wrong@example.com"
      session[:user_id] = @wrong_user.id
    end

    it "redirects when attempting to edit another's profile" do
      get :edit, params: { id: @u }
      e(response).to redirect_to root_url
    end

    it "redirects when attempting to update another's profile" do
      patch :update, params: { id: @u }
      e(response).to redirect_to root_url
    end

    it "redirects when attempting to destroy another's profile" do
      delete :destroy, params: { id: @u }
      e(response).to redirect_to root_url
    end

  end


  context "admin logged in" do

    before do
      @admin = User.create! user_attributes2 admin: true
      session[:user_id] = @admin.id
    end

    it "can delete another user's account" do
      expect{
        delete :destroy, params: { id: @u }
      }.to change(User, :count).by -1
    end

    it "cannot edit another user's account" do
      get :edit, params: { id: @u }
      e(response).to redirect_to root_url
    end

    it "cannot update another user's account" do
      patch :update, params: { id: @u }
      e(response).to redirect_to root_url
    end

  end


end
