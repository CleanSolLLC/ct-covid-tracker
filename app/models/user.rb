class User < ApplicationRecord
  has_many :data_points
  has_many :covid_stats, through: :data_points
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
