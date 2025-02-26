require 'rails_helper'

RSpec.describe "swot_analyses/show", type: :view do
  before(:each) do
    assign(:swot_analysis, SwotAnalysis.create!(
      business_idea: FactoryBot.create(:business_idea),
      strengths: "MyText",
      weaknesses: "MyText",
      opportunities: "MyText",
      threats: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
