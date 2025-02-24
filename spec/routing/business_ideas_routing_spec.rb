require "rails_helper"

RSpec.describe BusinessIdeasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/business_ideas").to route_to("business_ideas#index")
    end

    it "routes to #new" do
      expect(get: "/business_ideas/new").to route_to("business_ideas#new")
    end

    it "routes to #show" do
      expect(get: "/business_ideas/1").to route_to("business_ideas#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/business_ideas/1/edit").to route_to("business_ideas#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/business_ideas").to route_to("business_ideas#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/business_ideas/1").to route_to("business_ideas#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/business_ideas/1").to route_to("business_ideas#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/business_ideas/1").to route_to("business_ideas#destroy", id: "1")
    end
  end
end
