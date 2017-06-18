class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
    redirect_to login_url
    end
  end
  
  def counts(restaurant)
    @count_map = user.restaurants.count
    @count_visit = user.visit_restaurants.count
    @count_interest = user.interest_restaurants.count
  end
  
end
