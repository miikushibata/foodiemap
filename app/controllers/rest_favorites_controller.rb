class RestFavoritesController < ApplicationController
  
  include GurunaviUtil
  
  def create
    # @restaurant = Restaurant.find_or_initialize_by(params[:id]) #ここ違う気がする
    @restaurant = Restaurant.find_by(code: params[:rest_id])
    if @restaurant.blank?
      # @restaurantが保存されていない場合、先に@restaurantを保存する
      # require 'open-uri'
      # require 'uri'
      # res = open("https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=#{ENV['GURUNAVI_API_KEY_ID']}&format=json&id=#{params[:rest_id]}")
      # result = JSON.parse(res.read, {symbolize_names: true})
      # @restaurant = Restaurant.new(read(result))
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
    @restaurant = Restaurant.find(params[:rest_id])
    
    if params[:type] == 'Visit'
      current_user.unvisit(@restaurant)
      flash[:success] = 'このお店を「行った」から外しました'
    end
    redirect_back(fallback_location: root_path)
  end
  
end
