require 'rails_helper'

RSpec.describe "Ideas", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:idea) { FactoryBot.create(:idea, user: user) }
  let!(:other_idea) { FactoryBot.create(:idea, user: other_user, action_point: "another action point") }

  describe "GET /index" do
    context "when user is logged in" do
      before { sign_in user }

      it "returns only the user's ideas" do
        get ideas_path
        expect(response.body).to include(idea.action_point)
        expect(response.body).not_to include(other_idea.action_point)
      end
    end

    context "when user is not logged in" do
      it "redirects to sign-in page" do
        get ideas_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /show" do
    it "allows access to the owner's idea" do
      sign_in user
      get idea_path(idea)
      expect(response).to be_successful
    end

    it "prevents access to another user's idea" do
      sign_in user
      get idea_path(other_idea)
      expect(response).to redirect_to(ideas_path)
    end
  end

  describe "POST /create" do
    before { sign_in user }

    it "creates an idea with valid attributes" do
      expect {
        post ideas_path, params: { idea: { action_point: "New Idea", priority: "low" } }
      }.to change(Idea, :count).by(1)

      expect(response).to redirect_to(assigns(:idea))
    end

    it "renders errors with invalid attributes" do
      post ideas_path, params: { idea: { action_point: "" } }
      expect(response.body).to include("Action point can&#39;t be blank")
    end
  end

  describe "PATCH /update" do
    before { sign_in user }

    it "updates an idea with valid attributes" do
      patch idea_path(idea), params: { idea: { action_point: "Updated Idea" } }
      expect(response).to redirect_to(idea)
      expect(idea.reload.action_point).to eq("Updated Idea")
    end

    it "prevents updating another user's idea" do
      patch idea_path(other_idea), params: { idea: { action_point: "Hacked Idea" } }
      expect(response).to redirect_to(ideas_path)
      expect(other_idea.reload.action_point).not_to eq("Hacked Idea")
    end
  end

  describe "DELETE /destroy" do
    before { sign_in user }

    it "allows user to delete their idea" do
      expect {
        delete idea_path(idea)
      }.to change(Idea, :count).by(-1)

      expect(response).to redirect_to(ideas_path)
    end

    it "prevents user from deleting another user's idea" do
      expect {
        delete idea_path(other_idea)
      }.not_to change(Idea, :count)

      expect(response).to redirect_to(ideas_path)
    end
  end
end
