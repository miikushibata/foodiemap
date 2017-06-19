module GurunaviUtil
  def gurunavi_base_url
    "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=#{ENV['GURUNAVI_API_KEY_ID']}&hit_per_page=10&format=json&"
  end
  
  def gurunavi_by_keyword(keyword)
    keyword = URI.escape(keyword)
    url = "#{gurunavi_base_url}&freeword=#{keyword}"
    json = gurunavi_search(url)
    restaurants = []
    json[:rest].each do |data|
      restaurants << Restaurant.new(gurunavi_to_app_data(data))
    end
    restaurants
  end
  
  def gurunavi_by_id(id)
    url = "#{gurunavi_base_url}&id=#{id}"
    json = gurunavi_search(url)
    restaurant = Restaurant.new(gurunavi_to_app_data(json[:rest]))
    restaurant
  end
  
  def gurunavi_search(url)
    res = open(url)
    JSON.parse(res.read, {symbolize_names: true})
  end
  
  def gurunavi_to_app_data(data)
    {
      code:      data[:id],
      name:      data[:name],
      url:       data[:url],
      image_url: data[:image_url][:shop_image1],
      address:   data[:address],
      latitude:  data[:latitude],
      longitude: data[:longitude],
      pr_short:  data[:pr][:pr_short]
    }
  end
  
  
end