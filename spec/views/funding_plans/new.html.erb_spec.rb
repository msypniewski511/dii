require 'rails_helper'

RSpec.describe "funding_plans/new", type: :view do
  before(:each) do
    assign(:funding_plan, FundingPlan.new(
      business_idea: nil,
      bank_loan_borrowing: "MyText",
      alternative_funding: "MyText"
    ))
  end

  it "renders new funding_plan form" do
    render

    assert_select "form[action=?][method=?]", funding_plans_path, "post" do

      assert_select "input[name=?]", "funding_plan[business_idea_id]"

      assert_select "textarea[name=?]", "funding_plan[bank_loan_borrowing]"

      assert_select "textarea[name=?]", "funding_plan[alternative_funding]"
    end
  end
end
