require "rails_helper"

RSpec.describe PestelAnalysesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/pestel_analyses").to route_to("pestel_analyses#index")
    end

    it "routes to #new" do
      expect(get: "/pestel_analyses/new").to route_to("pestel_analyses#new")
    end

    it "routes to #show" do
      expect(get: "/pestel_analyses/1").to route_to("pestel_analyses#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/pestel_analyses/1/edit").to route_to("pestel_analyses#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/pestel_analyses").to route_to("pestel_analyses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/pestel_analyses/1").to route_to("pestel_analyses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/pestel_analyses/1").to route_to("pestel_analyses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/pestel_analyses/1").to route_to("pestel_analyses#destroy", id: "1")
    end
  end
end
