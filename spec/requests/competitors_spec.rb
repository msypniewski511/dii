require 'rails_helper'

RSpec.describe "Competitors", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/competitors/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/competitors/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/competitors/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/competitors/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
