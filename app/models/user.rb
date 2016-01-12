class User < ActiveRecord::Base
  has_secure_password

  validates :password, presence: true, length: { minimum: 1 }
  validates :email, presence: true, uniqueness: true

  has_many :links
end
