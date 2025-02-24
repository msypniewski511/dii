require 'rails_helper'

RSpec.describe "pestel_analyses/new", type: :view do
  before(:each) do
    assign(:pestel_analysis, PestelAnalysis.new(
      business_idea: nil,
      political: "MyText",
      economic: "MyText",
      social: "MyText",
      technological: "MyText",
      environmental: "MyText",
      legal: "MyText"
    ))
  end

  it "renders new pestel_analysis form" do
    render

    assert_select "form[action=?][method=?]", pestel_analyses_path, "post" do

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
