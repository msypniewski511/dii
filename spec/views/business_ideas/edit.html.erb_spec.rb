require 'rails_helper'

RSpec.describe "business_ideas/edit", type: :view do
  let(:business_idea) {
    BusinessIdea.create!(
      title: "MyString",
      description: "MyText",
      country: "MyString"
    )
  }

  before(:each) do
    assign(:business_idea, business_idea)
  end

  it "renders the edit business_idea form" do
    render

    assert_select "form[action=?][method=?]", business_idea_path(business_idea), "post" do

      assert_select "input[name=?]", "business_idea[title]"

      assert_select "textarea[name=?]", "business_idea[description]"

      assert_select "input[name=?]", "business_idea[country]"
    end
  end
end
