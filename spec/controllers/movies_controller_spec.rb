require 'rails_helper'

describe MoviesController do

  before(:each) do
    @u = User.create! user_attributes admin: false
    @m = Movie.create! movie_attributes
    session[:user_id] = @u.id
  end

  context "Unauthorized admin access" do

    it "Cannot access movie new" do
      get :new
      e(response).to redirect_to root_url
    end

    it "Cannot access movie create" do
      post :create
      e(response).to redirect_to root_url
    end

    it "Cannot access movie edit" do
      get :edit, params: { id: @m }
      e(response).to redirect_to root_url
    end

    it "Cannot access movie update" do
      patch :update, params: { id: @m }
      e(response).to redirect_to root_url
    end

    it "Cannot access movie destroy" do
      delete :destroy, params: { id: @m }
      e(response).to redirect_to root_url
    end

  end



end
