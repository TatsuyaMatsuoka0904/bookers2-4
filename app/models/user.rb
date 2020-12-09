class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	has_many :user_room
	has_many :chats
  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followed_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  
  def following?(other_user)
    self.followed_user.include?(other_user)
  end

  def follow(other_user)
    unless self == other_user
      self.follower.find_or_create_by(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    following = self.follower.find_by(followed_id: other_user.id)
    following.destroy if follower
  end
end
