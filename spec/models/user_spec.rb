require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.new(email: "test@example.com",
                     password: "password",
                     password_confirmation: "password") }

  it "can be created with valid attributes" do
    user.save
    expect(user).to be_valid
  end

  it "has a password digest instead of a password" do
    user.save
    user = User.last
    expect(user.password).to eq(nil)
    expect(user.password_digest).not_to eq("password")
  end

  it "must have an email" do
    @user = User.new(email: "",
                     password: "password",
                     password_confirmation: "password")
    expect(@user).not_to be_valid
  end

  it "must have a unique email" do
    user.save
    user2 = User.new(email: "test@example.com",
                     password: "password2",
                     password_confirmation: "password2")
    expect(user2).not_to be_valid
  end

  it "should not be valid without password" do
    @user = User.new(email: "test@example.com",
                     password: "",
                     password_confirmation: "")
    expect(@user).not_to be_valid
  end

  it "should not be valid with confirmation mismatch" do
    @user = User.new(email: "test@example.com",
                     password: "password",
                     password_confirmation: "passwrd")
    expect(@user).not_to be_valid
  end
end
