class Micropost < ActiveRecord::Base
  belongs_to :user
  
  has_many :favorites
  has_many :favorite_microposts, through: :favorites, source: :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
