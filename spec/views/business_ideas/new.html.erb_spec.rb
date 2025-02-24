require 'rails_helper'

RSpec.describe "business_ideas/new", type: :view do
  before(:each) do
    assign(:business_idea, BusinessIdea.new(
      title: "MyString",
      description: "MyText",
      country: "MyString"
    ))
  end

  it "renders new business_idea form" do
    render

    assert_select "form[action=?][method=?]", business_ideas_path, "post" do

      assert_select "input[name=?]", "business_idea[title]"

      assert_select "textarea[name=?]", "business_idea[description]"

      assert_select "input[name=?]", "business_idea[country]"
    end
  end
end
