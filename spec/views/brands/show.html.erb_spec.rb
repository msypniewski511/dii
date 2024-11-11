require 'rails_helper'

RSpec.describe "brands/show", type: :view do
  before(:each) do
    assign(:brand, Brand.create!(
      business_name: "Business Name",
      website_domain: "Website Domain"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Business Name/)
    expect(rendered).to match(/Website Domain/)
  end
end
