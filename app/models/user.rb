
class User < ActiveRecord::Base
  has_many :videos, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy


  before_save { email.downcase! }

  validates :first_name, :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 80 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false}

  has_secure_password

  validates :password, length: { minimum: 3, maximum: 20 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def to_s
    email
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
