require 'rails_helper'

RSpec.describe "pestel_analyses/show", type: :view do
  before(:each) do
    assign(:pestel_analysis, PestelAnalysis.create!(
      business_idea: nil,
      political: "MyText",
      economic: "MyText",
      social: "MyText",
      technological: "MyText",
      environmental: "MyText",
      legal: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
