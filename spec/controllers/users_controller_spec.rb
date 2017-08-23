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


end
