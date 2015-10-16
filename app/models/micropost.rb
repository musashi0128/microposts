class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  
  has_many :favoriteships, foreign_key: "micropost_id", 
                           dependent: :destroy
  has_many :favorite_users, through: :favoriteships, source: :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  mount_uploader :picture, PictureUploader
  
   private

    # アップロード画像のサイズを検証する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
  
end
