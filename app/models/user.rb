class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy

  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"
  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower

  validates :name, presence: true, length: { minimum: 6, maximun: 50 }
  validates :username, presence: true, length: { minimum: 6, maximun: 20 }
  validates :username, uniqueness: true
  validates :username, :format => { :with => /\A(?=.*[a-z])[a-z\d]+\Z/i }
end
