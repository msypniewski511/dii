require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/pestel_analyses", type: :request do
  before { skip("Waiting for a decision about the relationship between the models") }
  # This should return the minimal set of attributes required to create a valid
  # PestelAnalysis. As you add validations to PestelAnalysis, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      PestelAnalysis.create! valid_attributes
      get pestel_analyses_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      pestel_analysis = PestelAnalysis.create! valid_attributes
      get pestel_analysis_url(pestel_analysis)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_pestel_analysis_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      pestel_analysis = PestelAnalysis.create! valid_attributes
      get edit_pestel_analysis_url(pestel_analysis)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PestelAnalysis" do
        expect {
          post pestel_analyses_url, params: { pestel_analysis: valid_attributes }
        }.to change(PestelAnalysis, :count).by(1)
      end

      it "redirects to the created pestel_analysis" do
        post pestel_analyses_url, params: { pestel_analysis: valid_attributes }
        expect(response).to redirect_to(pestel_analysis_url(PestelAnalysis.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PestelAnalysis" do
        expect {
          post pestel_analyses_url, params: { pestel_analysis: invalid_attributes }
        }.to change(PestelAnalysis, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post pestel_analyses_url, params: { pestel_analysis: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested pestel_analysis" do
        pestel_analysis = PestelAnalysis.create! valid_attributes
        patch pestel_analysis_url(pestel_analysis), params: { pestel_analysis: new_attributes }
        pestel_analysis.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the pestel_analysis" do
        pestel_analysis = PestelAnalysis.create! valid_attributes
        patch pestel_analysis_url(pestel_analysis), params: { pestel_analysis: new_attributes }
        pestel_analysis.reload
        expect(response).to redirect_to(pestel_analysis_url(pestel_analysis))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        pestel_analysis = PestelAnalysis.create! valid_attributes
        patch pestel_analysis_url(pestel_analysis), params: { pestel_analysis: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested pestel_analysis" do
      pestel_analysis = PestelAnalysis.create! valid_attributes
      expect {
        delete pestel_analysis_url(pestel_analysis)
      }.to change(PestelAnalysis, :count).by(-1)
    end

    it "redirects to the pestel_analyses list" do
      pestel_analysis = PestelAnalysis.create! valid_attributes
      delete pestel_analysis_url(pestel_analysis)
      expect(response).to redirect_to(pestel_analyses_url)
    end
  end
end
