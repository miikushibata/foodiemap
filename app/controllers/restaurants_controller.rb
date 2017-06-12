class RestaurantsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
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
