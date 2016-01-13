require 'rails_helper'

RSpec.describe Link, type: :model do
  let!(:link) { Link.new(url: "https://www.google.com/", title: "Google")}

  it "can be created with valid attributes" do
    expect(link).to be_valid
  end

  it "cannot be created with invalid url" do
    @link = Link.new(url: "blah", title: "Nope")
    @link.save
    expect(@link).to_not be_valid
  end

  it "has a default read status of false" do
    link.save

    expect(link.read).to eq(false)
  end
end
