require 'rails_helper'

RSpec.describe "brands/index", type: :view do
  before(:each) do
    assign(:brands, [
      Brand.create!(
        business_name: "Business Name",
        website_domain: "Website Domain"
      ),
      Brand.create!(
        business_name: "Business Name",
        website_domain: "Website Domain"
      )
    ])
  end

  it "renders a list of brands" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Business Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Website Domain".to_s), count: 2
  end
end
