shared_context "features" do

  let!(:user) do
    User.create(email: "user@example.com",
                password: "password",
                password_confirmation: "password")
  end

  let!(:user_two) do
    User.create(email: "usertwo@example.com",
                password: "password2",
                password_confirmation: "password2")
  end

  def log_in_as(email, password)
  visit "/"
  click_link("Log In")
  fill_in "user[email]", with: username
  fill_in "user[password]", with: password
  click_button "Log In"
end
end