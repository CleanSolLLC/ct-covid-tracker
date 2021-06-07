class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, :dependent => :delete_all
  has_many :users, through: :comments



  validates :title, :content, presence: true
end
