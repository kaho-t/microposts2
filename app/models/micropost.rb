class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: {maximum: 140}
  
  has_many :favorites
  has_many :liked_users, through: :favorites, source: :user
end
