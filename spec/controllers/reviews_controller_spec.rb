require 'rails_helper'

describe ReviewsController do

  context "not signed in" do

    before do
      @movie = Movie.create! movie_attributes
    end

    it "cannot access new" do
      get :new, params: { movie_id: @movie }
      e(response).to redirect_to signin_url
    end

    it "cannot access create" do
      post :create, params: { movie_id: @movie }
      e(response).to redirect_to signin_url
    end

    it "cannot access index" do
      get :index, params: { movie_id: @movie }
      e(response).to redirect_to signin_url
    end

  end

end
