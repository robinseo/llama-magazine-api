class User < ApplicationRecord
  has_secure_password #It uses Bcrypt, cost factor of which is 12

  validates :email, on: :create, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, on: :create, confirmation: true, length: { minimum: 4 }
  validates_presence_of :password_confirmation, on: :create
  validates_presence_of :nickname, on: :create

  has_many :posts
  has_many :likes
  has_many :comments

  before_create { |user| user.token = generate_secure_uuid }

  def authenticate!(password)
    user = self.authenticate(password)
    raise ApiException::InvalidPassword unless user

    user
  end

  def generate_tokens!
    self.update!(token: generate_secure_uuid)

    self
  end

  def invalidate_token!
    self.update!(token: nil)

    self
  end

  def generate_secure_uuid
    uuid = SecureRandom.uuid
    key = Rails.application.secret_key_base
    digest = OpenSSL::HMAC.digest("SHA256", key, uuid)

    Base64.strict_encode64(digest) # use strict_encode64 method instead encode64. encode64 works weirdly.
  end
end
