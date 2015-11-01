class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_create :create_remember_token
  has_secure_password

  has_many :posts

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  def create_remember_token
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if self.remember_digest.nil?
    Digest::SHA1.hexdigest(remember_token) == self.remember_digest
  end

  def delete_remember_token
    update_attribute(:remember_digest, nil)
  end

end
