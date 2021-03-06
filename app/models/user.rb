class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :profile, length: { maximum: 255 }
  validates :area, length: { maximum: 50 }
  has_secure_password
  
  
  has_many :microposts
  
  # あなたがフォロー
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  # あなたをフォロー
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  # お気に入り登録
  has_many :favoriteships,  class_name: "Favoriteship",
                            foreign_key: "user_id", 
                            dependent: :destroy
  has_many :favorited_microposts, through: :favoriteships, source: :micropost
  
  
  has_many :retweetships,   class_name: "Retweetship",
                            foreign_key: "user_id", 
                            dependent: :destroy
  has_many :retweeted_microposts, through: :retweetships, source: :micropost
  

  
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # お気に入りする
  def favorite(micropost)
    favoriteships.find_or_create_by(micropost_id: micropost.id)
  end
  # お気に入りを解除する
  def unfavorite(micropost)
    favoriteships.find_by(micropost_id: micropost.id).destroy
  end
  # お気に入りにしているか？
  def favorite?(micropost)
    favorited_microposts.include?(micropost)
  end
  
  def retweet(micropost)
    retweetships.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unretweet(micropost)
    retweetships.find_by(micropost_id: micropost.id).destroy
  end
  
  def retweet?(micropost)
    retweeted_microposts.include?(micropost)
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
