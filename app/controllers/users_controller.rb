class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  def show
    @user = User.find(params[:id])
    @restaurants = @user.restaurants.uniq
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  def map
    @user = User.find(params[:id])
    @restaurants = []
    @restaurants << @user.visit_restaurants
    @restaurants << @user.interest_restaurants
    @restaurants = @restaurants.flatten.uniq
    
    #Google Map表示
    @hash = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow render_to_string(partial: "restaurants/infowindow", locals: { restaurant: restaurant })
      marker.json({name: restaurant.name}) #地図上のアイコン？
    end
  end
  
  def visit_list
    @user = User.find(params[:id])
    @visit_restaurants = @user.visit_restaurants
    @visited_codes = current_user.visit_restaurants.pluck(:code)
    @interest_codes = current_user.interest_restaurants.pluck(:code)
  end
  
  def interest_list
    @user = User.find(params[:id])
    @interest_restaurants = @user.interest_restaurants
    @visited_codes = current_user.visit_restaurants.pluck(:code)
    @interest_codes = current_user.interest_restaurants.pluck(:code)
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end