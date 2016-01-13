require "rails_helper"

feature "Visitor logging in", js: true do
let!(:user) { User.create!(email: "user@example.com",
                           password: "password",
                           password_confirmation: "password") }

  scenario "works with valid information" do
    visit "/"
    click_link "Log In"
    fill_in "user[email]", with: "user@example.com"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    expect(current_path).to eq("/links")
    expect(page).to have_content("Log Out")
  end

  scenario "doesn't work with invalid information" do
    visit "/"
    click_link "Log In"
    fill_in "user[email]", with: ""
    fill_in "user[password]", with: "fakepassword"
    click_button "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Incorrect login")
  end
end