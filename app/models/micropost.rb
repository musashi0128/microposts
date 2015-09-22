class Micropost < ActiveRecord::Base
  belongs_to :user
  
  has_many :favoriteships, class_name: "Favoriteship", 
                           foreign_key: "micropost_id", 
                           dependent: :destroy
  has_many :favorite_users, through: :favoriteships
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
