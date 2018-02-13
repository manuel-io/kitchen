class User < ActiveRecord::Base
  attr_accessor :email_verify

  validates :email, presence: true, uniqueness: true
  validates :nick,  presence: true, uniqueness: true
  validates :password_digest, presence: true
end
