require "rails_helper"

feature "Logged in user" do

  scenario "can log out" do
    User.create(email: "user@example.com",
                password: "password",
                password_confirmation: "password")
    visit "/"
    click_link "Log In"
    fill_in "user[email]", with: "user@example.com"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    expect(current_path).to eq("/links")
    expect(page).to have_content("Log Out")

    click_link "Log Out"

    expect(current_path).to eq("/")
    expect(page).to have_link("Log In")
    expect(page).to have_no_link("Log Out")
  end

end