require "rails_helper"

feature "Authenticated user viewing links index" do

  scenario "sees form to submit link" do
    User.create(email: "user@example.com",
                password: "password",
                password_confirmation: "password")
    visit "/"
    click_link "Log In"
    fill_in "user[email]", with: "user@example.com"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    expect(current_path).to eq("/links")
    expect(page).to have_content("Submit a Link")
  end

end