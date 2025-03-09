require 'rails_helper'

RSpec.describe "CompetitorAnalyses", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/competitor_analyses/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/competitor_analyses/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/competitor_analyses/show"
      expect(response).to have_http_status(:success)
    end
  end

end
