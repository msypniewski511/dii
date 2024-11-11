require 'rails_helper'

RSpec.describe "brands/edit", type: :view do
  let(:brand) {
    Brand.create!(
      business_name: "MyString",
      website_domain: "MyString"
    )
  }

  before(:each) do
    assign(:brand, brand)
  end

  it "renders the edit brand form" do
    render

    assert_select "form[action=?][method=?]", brand_path(brand), "post" do

      assert_select "input[name=?]", "brand[business_name]"

      assert_select "input[name=?]", "brand[website_domain]"
    end
  end
end
