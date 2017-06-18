class RestFavoritesController < ApplicationController
  
  include GurunaviUtil
  
  def create
    @restaurant = Restaurant.find_by(code: params[:rest_id])
    if @restaurant.blank?
      @restaurant = gurunavi_by_id(params[:rest_id])
      @restaurant.save
    end
    
    #Visit関係として保存
    if params[:type] == 'Visit'
      current_user.visit(@restaurant)
      flash[:success] = 'このお店を「行った」登録しました'
    end
    
    if params[:type] == 'Interest'
      current_user.interest(@restaurant)
      flash[:success] = 'このお店を「行きたい」登録しました'
    end
    
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find_by(code: params[:rest_id])
    
    if params[:type] == 'Visit'
      current_user.unvisit(@restaurant)
      flash[:success] = 'このお店の「行った」登録を外しました'
    end
    
    if params[:type] == 'Interest'
      current_user.uninterest(@restaurant)
      flash[:success] = 'このお店の「行きたい」登録を外しました'
    end
    
    redirect_back(fallback_location: root_path)
  end
  
end
