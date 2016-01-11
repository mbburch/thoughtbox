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

  scenario "sees all of their links" do
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

    fill_in "link[url]", with: "http://google.com"
    fill_in "link[title]", with: "Google"
    click_on "Submit"

    fill_in "link[url]", with: "http://facebook.com"
    fill_in "link[title]", with: "Facebook"
    click_on "Submit"

    expect(page).to have_content("Google")
    expect(page).to have_content("Facebook")
  end

  scenario "can mark link as read or unread" do
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

    fill_in "link[url]", with: "http://google.com"
    fill_in "link[title]", with: "Google"
    click_on "Submit"

    fill_in "link[url]", with: "http://facebook.com"
    fill_in "link[title]", with: "Facebook"
    click_on "Submit"

    page.first(".mark-read").click

    expect(Link.first.read).to eq(true)
    byebug
    page.first(".mark-unread").click

    expect(Link.first.read).to eq(false)
  end

end