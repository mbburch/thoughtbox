class Link < ActiveRecord::Base
  belongs_to :user

  validates :url, url: true
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates :title, presence: true
end
