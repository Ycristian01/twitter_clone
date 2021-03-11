class Tweet < ApplicationRecord
  belongs_to :user

  validates :post, presence: true, length: {minimum:1, maximun: 10 }
end
