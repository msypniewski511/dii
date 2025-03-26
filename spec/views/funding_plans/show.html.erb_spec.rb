require 'rails_helper'

RSpec.describe "funding_plans/show", type: :view do
  before(:each) do
    assign(:funding_plan, FundingPlan.create!(
      business_idea: nil,
      bank_loan_borrowing: "MyText",
      alternative_funding: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
