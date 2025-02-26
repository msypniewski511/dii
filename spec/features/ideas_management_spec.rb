require 'rails_helper'

RSpec.feature "Idea Management", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:idea) { FactoryBot.create(:idea, user: user, action_point: "User's Idea") }
  let!(:other_idea) { FactoryBot.create(:idea, user: other_user, action_point: "Other User's Idea") }

  context "when user is logged in" do
    before { login_user(user) }

    scenario "User sees only their own ideas" do
      visit ideas_path

      expect(page).to have_content("User's Idea")
      expect(page).not_to have_content("Other User's Idea")
    end

    scenario "User creates a new idea" do
      visit new_idea_path

      fill_in "Action point", with: "New Business Idea"
      select "High", from: "Priority"
      click_button "Create Idea"

      expect(page).to have_content("Idea was successfully created.")
      expect(page).to have_content("New Business Idea")
    end

    scenario "User cannot create an empty idea" do
      visit new_idea_path
      click_button "Create Idea"

      expect(page).to have_content("can't be blank")
    end

    scenario "User edits their idea" do
      visit edit_idea_path(idea)

      fill_in "Action point", with: "Updated Idea"
      click_button "Update Idea"

      expect(page).to have_content("Idea was successfully updated.")
      expect(page).to have_content("Updated Idea")
    end

    scenario "User deletes their idea" do
      pending "We have to dcide to implement delete idea"
      visit ideas_path

      within("tr", text: idea.action_point) do
        click_link "Delete"
      end

      expect(page).to have_content("Idea was successfully destroyed.")
      expect(page).not_to have_content("User's Idea")
    end

    scenario "User cannot edit another user's idea" do
      visit edit_idea_path(other_idea)

      expect(page).to have_current_path(ideas_path)
      expect(page).to have_content("The idea you are looking for could not be found.")
    end

    scenario "User cannot delete another user's idea" do
      visit idea_path(other_idea)

      expect(page).not_to have_link("Delete")
    end
  end

  context "when user is not logged in" do
    scenario "Redirects to sign-in page when accessing ideas index" do
      visit ideas_path

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "Redirects to sign-in page when trying to create a new idea" do
      visit new_idea_path

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "Redirects to sign-in page when trying to edit an idea" do
      visit edit_idea_path(idea)

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "Redirects to sign-in page when trying to delete an idea" do
      page.driver.submit :delete, idea_path(idea), {}

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
