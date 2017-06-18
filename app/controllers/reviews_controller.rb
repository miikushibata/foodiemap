class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
    else
      #@reviews = current_user.reviews.
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
    end
    redirect_to restaurant_url(@review.restaurant_id)
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:date, :content, :restaurant_id)
  end
end
