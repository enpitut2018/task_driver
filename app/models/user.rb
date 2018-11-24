class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
         
         def self.find_for_oauth(auth)
          user = User.where(uid: auth.uid, provider: auth.provider).first
      
          unless user
            user = User.create(
              uid:      auth.uid,
              provider: auth.provider,
              email:    User.dummy_email(auth),
              username: auth.info.nickname,
              password: Devise.friendly_token[0, 20]
            )
            #ここでGeneralタグ生成?
            group = Group.create(
              name: "General",
              user_id: user.id
              
            )
            group.save
          end

          user.skip_confirmation!
          


          user
        end
        
        private
        def self.dummy_email(auth)
          "#{auth.uid}-#{auth.provider}@example.com"
        end

end
