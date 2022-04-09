class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    unless user
     user = create_from_omniauth!(data)
    end

    user.skip_confirmation!
    user
  end

  private

  def self.create_from_omniauth!(data)
    User.create!(
      first_name: data['first_name'],
      last_name: data['last_name'],
      provider: data['provider'],
      uid: data['uid'],
      email: data['email'],
      password: Devise.friendly_token[0,20],
      avatar: data['image']
    )
  end
end
