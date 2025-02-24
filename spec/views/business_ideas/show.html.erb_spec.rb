require 'rails_helper'

RSpec.describe "business_ideas/show", type: :view do
  before(:each) do
    assign(:business_idea, BusinessIdea.create!(
      title: "Title",
      description: "MyText",
      country: "Country"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Country/)
  end
end
