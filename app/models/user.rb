class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_save :to_lowercase_email

  private
  def to_lowercase_email
    self.email = self.email.downcase
  end
end
