require "rails_helper"

RSpec.describe "Page Title", type: :system do
  it "displays the correct title for the Projects page" do
    visit "/" # Replace with your actual path

    title = "Startup Business Builder App"
    expect(page).to have_title title
  end
end
