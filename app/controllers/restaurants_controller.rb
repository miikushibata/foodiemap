class RestaurantsController < ApplicationController
  before_action :require_user_logged_in
  
  #h 追加(app/controllers/concerns/gurunavi_util.rb)
  include GurunaviUtil
  
  def index
    @restaurants = []
    @restaurants = gurunavi_by_keyword(params[:search][:q]) if params[:search].present? && params[:search][:q].present?
    @visited_codes = current_user.visit_restaurants.pluck(:code)
    @interest_codes = current_user.interest_restaurants.pluck(:code)
  end

  #保存されたレストラン詳細ページ
  def show
    @restaurant = Restaurant.find(params[:id])
    @user = current_user
    @review = current_user.reviews.build #form_for用
    #@reviews = @user.reviews  #review一覧表示用
    #@reviews = Review.where(restaurant_id: params[:id])
    @reviews = @restaurant.reviews
    @visited_codes = current_user.visit_restaurants.pluck(:code)
    @interest_codes = current_user.interest_restaurants.pluck(:code)
  end
  
end
