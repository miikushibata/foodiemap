class Restaurant < ApplicationRecord
  validates :code, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  
  has_many :rest_favorites
  has_many :users, through: :rest_favorites
  
  has_many :visits
  has_many :visit_users, through: :visits, class_name: 'User', source: :user

  has_many :interests
  has_many :interest_users, through: :interests, class_name: 'User', source: :user
  
  has_many :reviews
  has_many :users, through: :reviews
  
  #Google Map表示用
  geocoded_by :address
  after_validation :geocode

end