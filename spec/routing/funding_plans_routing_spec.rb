require "rails_helper"

RSpec.describe FundingPlansController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/funding_plans").to route_to("funding_plans#index")
    end

    it "routes to #new" do
      expect(get: "/funding_plans/new").to route_to("funding_plans#new")
    end

    it "routes to #show" do
      expect(get: "/funding_plans/1").to route_to("funding_plans#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/funding_plans/1/edit").to route_to("funding_plans#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/funding_plans").to route_to("funding_plans#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/funding_plans/1").to route_to("funding_plans#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/funding_plans/1").to route_to("funding_plans#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/funding_plans/1").to route_to("funding_plans#destroy", id: "1")
    end
  end
end
