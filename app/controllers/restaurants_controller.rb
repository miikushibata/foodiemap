class RestaurantsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
  end
  
  def create
    require 'open-uri'
    require 'uri'
    keyword = URI.escape(params[:search][:q])
    res = open("https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=#{ENV['GURUNAVI_API_KEY_ID']}&format=json&freeword=#{keyword}")
    result = JSON.parse(res.read, {symbolize_names: true})
    @rests = result[:rest]
    render :new
  end

  def show
  end
  
  private
 
   def build_url(query)
     url = 'http://api.gnavi.co.jp/RestSearchAPI/20150630/'
     query[:keyid] = keyid
     query[:format] = 'json'
     query[:freeword] = freeword
 
     url = url + '?' + query.to_query
   end
end
