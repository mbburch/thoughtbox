class User < ActiveRecord::Base
  validates :password, presence: true, length: { minimum: 1 }
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :links
end
