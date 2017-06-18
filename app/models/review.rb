class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  
  validates :date, presence: true, length: { maximum: 10 }
  validates :content, presence: true, length: { maximum: 255 }
end
