require 'rails_helper'

RSpec.describe "pestel_analyses/index", type: :view do
  before(:each) do
    assign(:pestel_analyses, [
      PestelAnalysis.create!(
        business_idea: nil,
        political: "MyText",
        economic: "MyText",
        social: "MyText",
        technological: "MyText",
        environmental: "MyText",
        legal: "MyText"
      ),
      PestelAnalysis.create!(
        business_idea: nil,
        political: "MyText",
        economic: "MyText",
        social: "MyText",
        technological: "MyText",
        environmental: "MyText",
        legal: "MyText"
      )
    ])
  end

  it "renders a list of pestel_analyses" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
