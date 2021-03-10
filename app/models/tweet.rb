class Tweet < ApplicationRecord
  belongs_to :user

  validates :post, presence: true, length: {minimum:0, maximun: 280 }
end
