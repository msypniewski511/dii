require 'rails_helper'

RSpec.feature "Business Ideas Management", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:business_idea) { FactoryBot.create(:business_idea, user: user) }
  let!(:other_business_idea) { FactoryBot.create(:business_idea, user: other_user) }

  context "when user is login" do
    before { login_user(user) }

    scenario "User can see only their own business ideas" do
      visit business_ideas_path
  
      expect(page).to have_content(business_idea.title)
      expect(page).to_not have_content(other_business_idea.title)
    end

    scenario "User cannot see other users' business ideas" do
      visit business_ideas_path
  
      expect(page).not_to have_content(other_business_idea.title)
    end

    scenario "User can create a business idea" do
      visit new_business_idea_path
  
      within("form") do
        fill_in "Title", with: "New Business Idea"
        fill_in "Description", with: "This is a test idea"
        select "United States", from: "Country"
        click_button "Create Business idea"
      end

      expect(page).to have_content("Business idea was successfully created.")
      expect(page).to have_content("New Business Idea")
    end

    scenario "User cannot create an empty business idea" do
      visit new_business_idea_path
      click_button "Create Business idea"

      expect(page).to have_content("can't be blank")
    end

    scenario "User edits their business idea" do
      visit edit_business_idea_path(business_idea)

      within("form") do
        fill_in "Title", with: "Updated Business Idea"
        click_button "Update Business idea"
      end

      expect(page).to have_content("Business idea was successfully updated.")
      expect(page).to have_content("Updated Business Idea")
    end

    scenario "User deletes their business idea" do
      visit business_ideas_path
      click_link "Delete this business idea"


      expect(page).to have_content("Business idea was successfully destroyed.")
      expect(page).not_to have_content(business_idea.title)
    end

    scenario "User cannot edit another user's business idea" do
      visit edit_business_idea_path(other_business_idea)

      expect(page).to have_current_path(user_root_path)
      expect(page).to have_content("You are not authorized to access this business idea.")
    end

    scenario "User cannot delete another user's business idea" do
      visit business_idea_path(other_business_idea)

      expect(page).not_to have_link("Delete")
    end
  end

  context "when user is not logged in" do
    scenario "Redirects to root_path when accessing business ideas index" do
      visit business_ideas_path

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    scenario "Redirects to root_path when trying to create a new business idea" do
      visit new_business_idea_path

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    scenario "Redirects to root_path when trying to edit a business idea" do
      visit edit_business_idea_path(business_idea)

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    scenario "Redirects to root_path when trying to delete a business idea" do
      page.driver.submit :delete, business_idea_path(business_idea), {}

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
