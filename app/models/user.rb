class User < ApplicationRecord
  has_many :contributions, dependent: :destroy
  has_many :groups, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.id, provider: "twitter").first
    
    unless user
      user = User.create(
        uid:      auth.id,
        provider: "twitter",
        email:    User.dummy_email(auth),
        username: auth.name,
        password: Devise.friendly_token[0, 20]
        )
    end
    
    user.skip_confirmation!
    user
  end

  private
  def self.dummy_email(auth)
    "#{auth.id}-#{"twitter"}@example.com"
  end
end