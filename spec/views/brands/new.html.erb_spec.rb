require 'rails_helper'

RSpec.describe "brands/new", type: :view do
  before(:each) do
    assign(:brand, Brand.new(
      business_name: "MyString",
      website_domain: "MyString"
    ))
  end

  it "renders new brand form" do
    render

    assert_select "form[action=?][method=?]", brands_path, "post" do

      assert_select "input[name=?]", "brand[business_name]"

      assert_select "input[name=?]", "brand[website_domain]"
    end
  end
end
