require 'rails_helper'

RSpec.describe "swot_analyses/index", type: :view do
  before(:each) do
    assign(:swot_analyses, [
      SwotAnalysis.create!(
        business_idea: nil,
        strengths: "MyText",
        weaknesses: "MyText",
        opportunities: "MyText",
        threats: "MyText"
      ),
      SwotAnalysis.create!(
        business_idea: nil,
        strengths: "MyText",
        weaknesses: "MyText",
        opportunities: "MyText",
        threats: "MyText"
      )
    ])
  end

  it "renders a list of swot_analyses" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
