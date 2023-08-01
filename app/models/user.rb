class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_save :to_lowercase_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    user && user.authenticate(password) ? user : nil
  end

  
  private
  def to_lowercase_email
    self.email = self.email.downcase
  end
end
