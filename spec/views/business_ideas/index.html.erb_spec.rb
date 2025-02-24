require 'rails_helper'

RSpec.describe "business_ideas/index", type: :view do
  before(:each) do
    assign(:business_ideas, [
      BusinessIdea.create!(
        title: "Title",
        description: "MyText",
        country: "Country"
      ),
      BusinessIdea.create!(
        title: "Title",
        description: "MyText",
        country: "Country"
      )
    ])
  end

  it "renders a list of business_ideas" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Country".to_s), count: 2
  end
end
