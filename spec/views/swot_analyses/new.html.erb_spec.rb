require 'rails_helper'

RSpec.describe "swot_analyses/new", type: :view do
  before(:each) do
    assign(:swot_analysis, SwotAnalysis.new(
      business_idea: FactoryBot.create(:business_idea),
      strengths: "MyText",
      weaknesses: "MyText",
      opportunities: "MyText",
      threats: "MyText"
    ))
  end

  it "renders new swot_analysis form" do
    render

    assert_select "form[action=?][method=?]", swot_analyses_path, "post" do

      assert_select "input[name=?]", "swot_analysis[business_idea_id]"

      assert_select "textarea[name=?]", "swot_analysis[strengths]"

      assert_select "textarea[name=?]", "swot_analysis[weaknesses]"

      assert_select "textarea[name=?]", "swot_analysis[opportunities]"

      assert_select "textarea[name=?]", "swot_analysis[threats]"
    end
  end
end
