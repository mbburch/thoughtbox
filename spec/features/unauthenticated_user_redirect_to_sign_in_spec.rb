require "rails_helper"

feature "unauthenticated user visits welcome page" do
  scenario "and is redirected to login" do
    visit "/"
    expect(page).to have_content("Log In or Sign Up")
  end
end