class User < ActiveRecord::Base
  
  require 'bcrypt'
  
  has_secure_password
  
  has_many :cats, :dependent => :destroy, :foreign_key => :owner_id, :primary_key => :id
  has_many :cat_rental_requests, :dependent => :destroy, :foreign_key => :renter_id, :primary_key => :id

  attr_reader :password
  
  after_initialize :ensure_session_token
  
  validates :username, :session_token, :presence => :true, :uniqueness => true
  validates :password_digest, :presence => true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user.is_password?(password)
      return user
    end
    nil
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.base64(32)
    self.save!
    self.session_token
  end
  
  def password=(password)
    # transform password parameter into hashed password_digest
    # save said password_digest in DB
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= SecureRandom.base64(32)
  end
  
end
