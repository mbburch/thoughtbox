require "rails_helper"

feature "Visitor signing up for account" do

  scenario "works with valid information" do
    visit "/"
    click_link "Sign Up"
    expect(current_path).to eq("/signup")
    fill_in "user[email]", with: "mb@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Submit"

    expect(current_path).to eq("/links")
  end

  scenario "does not work with invalid information" do
    visit "/"
    click_link "Sign Up"
    expect(current_path).to eq("/signup")
    fill_in "user[email]", with: "mb@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "passwrd"
    click_button "Submit"

    expect(current_path).to eq("/signup")
    expect(page).to have_content("Password confirmation doesn't match")
  end

  scenario "does not work with invalid information" do
    visit "/"
    click_link "Sign Up"
    expect(current_path).to eq("/signup")
    fill_in "user[email]", with: "mb@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Submit"

    expect(current_path).to eq("/links")

    visit "/"
    click_link "Sign Up"
    expect(current_path).to eq("/signup")
    fill_in "user[email]", with: "mb@example.com"
    fill_in "user[password]", with: "password2"
    fill_in "user[password_confirmation]", with: "password2"
    click_button "Submit"

    expect(current_path).to eq("/signup")
    expect(page).to have_content("Email has already been taken")
  end

end