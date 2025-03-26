require 'rails_helper'

RSpec.describe "funding_plans/index", type: :view do
  before(:each) do
    assign(:funding_plans, [
      FundingPlan.create!(
        business_idea: nil,
        bank_loan_borrowing: "MyText",
        alternative_funding: "MyText"
      ),
      FundingPlan.create!(
        business_idea: nil,
        bank_loan_borrowing: "MyText",
        alternative_funding: "MyText"
      )
    ])
  end

  it "renders a list of funding_plans" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
