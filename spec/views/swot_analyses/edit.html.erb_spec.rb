require 'rails_helper'

RSpec.describe "swot_analyses/edit", type: :view do
  let(:swot_analysis) {
    SwotAnalysis.create!(
      business_idea: nil,
      strengths: "MyText",
      weaknesses: "MyText",
      opportunities: "MyText",
      threats: "MyText"
    )
  }

  before(:each) do
    assign(:swot_analysis, swot_analysis)
  end

  it "renders the edit swot_analysis form" do
    render

    assert_select "form[action=?][method=?]", swot_analysis_path(swot_analysis), "post" do

      assert_select "input[name=?]", "swot_analysis[business_idea_id]"

      assert_select "textarea[name=?]", "swot_analysis[strengths]"

      assert_select "textarea[name=?]", "swot_analysis[weaknesses]"

      assert_select "textarea[name=?]", "swot_analysis[opportunities]"

      assert_select "textarea[name=?]", "swot_analysis[threats]"
    end
  end
end
