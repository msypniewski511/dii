require 'rails_helper'

RSpec.describe "Assessments", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/assessments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/assessments/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/assessments/show"
      expect(response).to have_http_status(:success)
    end
  end

end
