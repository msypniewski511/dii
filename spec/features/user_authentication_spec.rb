require 'rails_helper'

RSpec.feature "User Authentication", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  
  scenario "User logs in and sees dashboard" do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"
    click_button "Sign in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_current_path(user_root_path)
  end
end