class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy


  validates :name, presence: true, length: { minimum: 6, maximun: 50 }
  validates :username, presence: true, length: { minimum: 6, maximun: 20 }
  validates :username, uniqueness: true
  validates :username, :format => { :with => /\A(?=.*[a-z])[a-z\d]+\Z/i }
end
