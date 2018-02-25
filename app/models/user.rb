class User < ActiveRecord::Base
  has_secure_password

  before_validation do
    self.nick.downcase!
  end

  validates :nick, presence: true, uniqueness: true
  validates :email, uniqueness: true, confirmation: true
  validates :password, confirmation: true

  validates_exclusion_of :nick, in: %w|admin root user guest|
  validates_email_format_of :email

  validates_presence_of :email_confirmation, if: :email_changed?
  validates_presence_of :password_confirmation, if: :password_digest_changed?
end
