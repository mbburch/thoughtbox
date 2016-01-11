require 'rails_helper'

RSpec.describe "Links API", type: :request do
  let!(:user) { User.create!(email: "mb@example.com", password: "password", password_confirmation: "password") }
  let!(:link) { Link.create!(title: "google", url: "http://www.google.com", user_id: user.id) }
  let!(:link2) { Link.create!(title: "facebook", url: "http://www.facebook.com", user_id: user.id) }
  let(:json) { JSON.parse(response.body) }

  context "updating a link" do
    it "can mark a link as read or unread" do
      put "/api/v1/links/#{link.id}.json", {link: {read: true}}

      expect(response).to have_http_status 204
      expect(Link.first.read).to eq true
      expect(Link.last.read).to eq false

      put "/api/v1/links/#{link.id}.json", {link: {read: false}}

      expect(response).to have_http_status 204
      expect(Link.first.read).to eq false
      expect(Link.last.read).to eq false
    end
  end
end