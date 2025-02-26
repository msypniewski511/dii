require 'rails_helper'

RSpec.feature "Brand Management", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:brand) { FactoryBot.create(:brand, user: user, business_name: "User's Brand") }
  let!(:other_brand) { FactoryBot.create(:brand, user: other_user, business_name: "Other User's Brand") }

  context "when user is logged in" do
    before { login_user(user) }

    scenario "User can see only their own brands" do
      visit brands_path

      expect(page).to have_content("User's Brand")
      expect(page).not_to have_content("Other User's Brand")
    end

    scenario "User creates a new brand" do
      visit new_brand_path

      fill_in "Business name", with: "New Business Brand"
      fill_in "Website domain", with: "www.newbrand.com"
      click_button "Create Brand"

      expect(page).to have_content("Brand was successfully created.")
      expect(page).to have_content("New Business Brand")
    end

    scenario "User cannot create an empty brand" do
      visit new_brand_path
      click_button "Create Brand"

      expect(page).to have_content("can't be blank")
    end

    scenario "User edits their brand" do
      visit edit_brand_path(brand)

      fill_in "Business name", with: "Updated Brand"
      click_button "Update Brand"

      expect(page).to have_content("Brand was successfully updated.")
      expect(page).to have_content("Updated Brand")
    end

    scenario "User deletes their brand" do
      pending "We have to decide to keep brand"
      fail
      # visit brands_path

      # within("tr", text: brand.business_name) do
      #   click_link "Delete"
      # end

      # expect(page).to have_content("Brand was successfully destroyed.")
      # expect(page).not_to have_content("User's Brand")
    end

    scenario "User cannot edit another user's brand" do
      visit edit_brand_path(other_brand)

      expect(page).to have_current_path(brands_path)
      expect(page).to have_content("The brand you are looking for could not be found.")
    end

    scenario "User cannot delete another user's brand" do
      visit brand_path(other_brand)

      expect(page).not_to have_link("Delete")
    end
  end

  context "when user is not logged in" do
    scenario "Redirects to sign-in page when accessing brands index" do
      visit brands_path

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "Redirects to sign-in page when trying to create a new brand" do
      visit new_brand_path

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "Redirects to sign-in page when trying to edit a brand" do
      visit edit_brand_path(brand)

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "Redirects to sign-in page when trying to delete a brand" do
      page.driver.submit :delete, brand_path(brand), {}

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
