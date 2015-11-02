class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_create :create_remember_digest
  has_secure_password
  validates :password_digest, presence: true, length: { minimum:6 }

  has_many :posts

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  private

  def create_remember_digest
    self.remember_token = new_remember_token
    remember_digest = USer.digest(remember_token)
    update_attribute(:remember_digest, remember_digest)
  end

end
