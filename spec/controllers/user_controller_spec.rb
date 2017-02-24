require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #already" do
    it "returns http success" do
      get :already
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #profile" do
    it "returns http success" do
      get :profile
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #display" do
    it "returns http success" do
      get :display
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #showuser" do
    it "returns http success" do
      get :showuser
      expect(response).to have_http_status(:success)
    end
  end

end
