require 'rails_helper'

RSpec.describe "funding_plans/edit", type: :view do
  let(:funding_plan) {
    FundingPlan.create!(
      business_idea: nil,
      bank_loan_borrowing: "MyText",
      alternative_funding: "MyText"
    )
  }

  before(:each) do
    assign(:funding_plan, funding_plan)
  end

  it "renders the edit funding_plan form" do
    render

    assert_select "form[action=?][method=?]", funding_plan_path(funding_plan), "post" do

      assert_select "input[name=?]", "funding_plan[business_idea_id]"

      assert_select "textarea[name=?]", "funding_plan[bank_loan_borrowing]"

      assert_select "textarea[name=?]", "funding_plan[alternative_funding]"
    end
  end
end
