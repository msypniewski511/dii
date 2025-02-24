require 'rails_helper'

RSpec.describe "pestel_analyses/edit", type: :view do
  let(:pestel_analysis) {
    PestelAnalysis.create!(
      business_idea: nil,
      political: "MyText",
      economic: "MyText",
      social: "MyText",
      technological: "MyText",
      environmental: "MyText",
      legal: "MyText"
    )
  }

  before(:each) do
    assign(:pestel_analysis, pestel_analysis)
  end

  it "renders the edit pestel_analysis form" do
    render

    assert_select "form[action=?][method=?]", pestel_analysis_path(pestel_analysis), "post" do

      assert_select "input[name=?]", "pestel_analysis[business_idea_id]"

      assert_select "textarea[name=?]", "pestel_analysis[political]"

      assert_select "textarea[name=?]", "pestel_analysis[economic]"

      assert_select "textarea[name=?]", "pestel_analysis[social]"

      assert_select "textarea[name=?]", "pestel_analysis[technological]"

      assert_select "textarea[name=?]", "pestel_analysis[environmental]"

      assert_select "textarea[name=?]", "pestel_analysis[legal]"
    end
  end
end
