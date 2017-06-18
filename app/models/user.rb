class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  
  has_many :rest_favorites
  has_many :restaurants, through: :rest_favorites
  
  has_many :visits
  has_many :visit_restaurants, through: :visits, class_name: 'Restaurant', source: :restaurant
  
  has_many :interests
  has_many :interest_restaurants, through: :interests, class_name: 'Restaurant', source: :restaurant

  has_many :reviews
  has_many :restaurants, through: :reviews

 # Visit（行った）機能 
  def visit(restaurant)
    self.visits.find_or_create_by(restaurant_id: restaurant.id)
  end
  
  def unvisit(restaurant)
    visit = self.visits.find_by(restaurant_id: restaurant.id)
    visit.destroy if visit
  end
  
  def visit?(restaurant)
    self.visit_restaurants.include?(restaurant)
  end
  
# Interest(行きたい)機能
  def interest(restaurant)
    self.interests.find_or_create_by(restaurant_id: restaurant.id)
  end
  
  def uninterest(restaurant)
    interest = self.interests.find_by(restaurant_id: restaurant.id)
    interest.destroy if interest
  end
  
  def interest?(restaurant)
    self.interest_restaurants.include?(restaurant)
  end
  
end
