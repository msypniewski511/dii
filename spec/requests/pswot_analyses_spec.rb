require 'rails_helper'

RSpec.describe "PswotAnalyses", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/pswot_analyses/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/pswot_analyses/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/pswot_analyses/show"
      expect(response).to have_http_status(:success)
    end
  end

end
