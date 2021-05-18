class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :states
  has_many :ethnic_cases
  has_many :age_groups
  has_many :gender_cases
  has_many :counties
  has_many :towns
  has_many :comments, dependent: :destroy
  has_many :posts, through: :comments, dependent: :destroy
end
