class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]       
  
  has_many :states
  has_many :ethnic_cases
  has_many :age_groups
  has_many :gender_cases
  has_many :counties
  has_many :towns
  has_many :comments, dependent: :destroy
  has_many :posts, through: :comments, dependent: :destroy


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user

        user = User.create(username: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
end
end
