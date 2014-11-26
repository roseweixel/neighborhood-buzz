require 'open-uri'
require 'date'
require 'flickr.rb'

class Neighborhood < ActiveRecord::Base
  belongs_to :borough
  has_many :favorites
  has_many :users, through: :favorites
  has_many :restaurants
  has_many :bars

  

  YELP_CLIENT = Yelp::Client.new({ consumer_key: ENV["YELP_CONSUMER_KEY"],
                                consumer_secret: ENV["YELP_CONSUMER_SECRET"],
                                token: ENV["YELP_TOKEN"],
                                token_secret: ENV["YELP_TOKEN_SECRET"]
                              })


  def urlified_name
    name.gsub(" ", "+")
  end

  def get_week
    week = Date.today.cweek
    if week == 53
        week = 52
    end
    week
  end

  def get_year
    Date.today.year
  end

  def find_50th_percentile
    type = "json"
    # the nytimes api call has to ask for get_week - 1 because of the following error: {"status":"ERROR","copyright":"Copyright (c) 2014 The New York Times Company.  All Rights Reserved.","errors":["Invalid Date: 2014-11-24.  Date value has to be earlier than today.","Not Found"],"results":[]}
    url = "http://api.nytimes.com/svc/real-estate/v2/listings/percentile/50.#{type}?date-range=#{get_year}-W#{get_week - 1}&geo-extent-level=neighborhood&geo-extent-value=#{urlified_name}&api-key=#{ENV["NY_TIMES_API_KEY"]}"
    info_hash = JSON.load(open(url))
    info_hash["results"][0]["listing_price"]
  end

  def self.persist_median_buy_prices
    Neighborhood.all.each do |neighborhood|
      sleep(0.1)
      money_string = neighborhood.find_50th_percentile
      result = money_string.gsub(/[$,]/, "").to_i
      neighborhood.update(median_buy_price: result)
    end
  end

  def self.remove_duplicates
    Neighborhood.all.each do |neighborhood|
      copies =  Neighborhood.all.where(name: neighborhood.name)
      while copies.size > 1
        copies.last.destroy
        copies =  Neighborhood.all.where(name: neighborhood.name)
      end
    end
  end

  def get_yelp_top_three_bars
    info = []
    params = { term: 'bar',
               limit: 3,
               sort: 2 # sort by rating
         }
    results = YELP_CLIENT.search("#{name}, New York", params).businesses
    results.each do |result|
      temp_hash = {}
      temp_hash[:name] = result.name
      temp_hash[:address] = result.location.address[0]
      temp_hash[:url] = result.url
      temp_hash[:stars_img] = result.rating_img_url_large
      info << temp_hash
    end
    info
  end

  def get_yelp_top_three_restaurants
    info = []
    params = { term: 'restaurant',
               limit: 3,
               sort: 2 # sort by rating
         }
    results = YELP_CLIENT.search("#{name}, New York", params).businesses
    results.each do |result|
      temp_hash = {}
      temp_hash[:name] = result.name
      temp_hash[:address] = result.location.address[0]
      temp_hash[:url] = result.url
      temp_hash[:stars_img] = result.rating_img_url_large
      info << temp_hash
    end
    info
  end

 
  def find_se_rentals
      url = "http://streeteasy.com/nyc/api/rentals/data?criteria=area:#{urlified_name}-#{borough}\|&key=#{ENV["SE_API_KEY"]}&format=json"
      encoded_url = URI.encode(url)
      info_hash = JSON.load(open(encoded_url))

      {median_price: info_hash["median_price"], search_url: info_hash["search_url"]}
  end

  def noko_listing
      se_hash = find_se_rentals
      ret_hash = {}
      listings_page = Nokogiri::HTML(open(se_hash[:search_url]))

      if listings_page.css(".left-two-thirds .photo img").first
        if listings_page.css(".left-two-thirds .photo img")[2]
          ret_hash[:img_url_1] = listings_page.css(".left-two-thirds .photo img")[2].attributes["data-original"].value
        end
        if listings_page.css(".left-two-thirds .photo img")[3]
          ret_hash[:img_url_2] = listings_page.css(".left-two-thirds .photo img")[3].attributes["data-original"].value
        end
        if listings_page.css(".left-two-thirds .photo img")[4]
          ret_hash[:img_url_3] = listings_page.css(".left-two-thirds .photo img")[4].attributes["data-original"].value
        end
      else
        ret_hash[:img_url_1] = "app/assets/images/apt-stock-photo-1.jpg"
        ret_hash[:img_url_2] = "app/assets/images/apt-stock-photo-2.jpg"
        ret_hash[:img_url_3] = "app/assets/images/apt-stock-photo-3.jpg"
      end

      root_url = "http://streeteasy.com"
        
      # was janky to get nokogiri to pull links and images from same listing, hence the seemingly random array values  
      if listings_page.css(".details-title a")[4]
        append_url_1 = listings_page.css(".details-title a")[4].attributes["href"].value
        ret_hash[:listing_url_1] = root_url + append_url_1
        if listings_page.css(".price")[2]
          ret_hash[:monthly_rent_1] = listings_page.css(".price")[2].children.text
        end
      end

      if listings_page.css(".details-title a")[6]
        append_url_2 = listings_page.css(".details-title a")[6].attributes["href"].value
        ret_hash[:listing_url_2] = root_url + append_url_2
        if listings_page.css(".price")[3]
          ret_hash[:monthly_rent_2] = listings_page.css(".price")[3].children.text
        end
      end

      if listings_page.css(".details-title a")[8]
        append_url_3 = listings_page.css(".details-title a")[8].attributes["href"].value
        ret_hash[:listing_url_3] = root_url + append_url_3
        if listings_page.css(".price")[4]
          ret_hash[:monthly_rent_3] = listings_page.css(".price")[4].children.text
        end
      end
      
      ret_hash[:search_url] = se_hash[:search_url]
      ret_hash[:median_rent] = prettify_median_price(se_hash[:median_price])
      ret_hash[:median_rent_integer] = se_hash[:median_price]
      ret_hash
  end


  def prettify_median_price(price)
    formatted_string = "$"
    formatted_array = []
    unformatted_string = price.to_s
    #binding.pry
    string_array = unformatted_string.split("")
    while string_array.length >= 4
      3.times do
        formatted_array.unshift(string_array.pop)
      end
      formatted_array.unshift(",")
    end
    while string_array.length > 0
      formatted_array.unshift(string_array.pop)
    end
    formatted_string << (formatted_array.join)
    formatted_string
  end

  def twitterified_name
    new_name = name.gsub(" ", "")
    # new_name + "nyc"
  end

  def get_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    end
    tweets = []
    client.search("##{twitterified_name} #nyc").each do |tweet|
      tweets << tweet
      if tweets.count == 5
        return tweets
      end
    end
    if tweets.count == 0
      client.search("##{borough} #nyc").each do |tweet|
        tweets << tweet
        if tweets.count == 5
          return tweets
        end
      end
    end
    return tweets
  end

  def get_flickr
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_SHARED_SECRET"]
    # flickr_place = flickr.places.find(:query => "#{name}, New York")
    # place_id = flickr_place[0].place_id
    place_id = FLICKR_PLACE_IDS[name]
    if place_id != "NO PICTURE FOUND"
      photo_hash = flickr.photos.search(:text => name, :place_id => place_id, :per_page => '1', :extras => 'url_o')
      photo_url = photo_hash[0]["url_o"]
      return photo_url
    end
    return nil
  end

  def slug
    name.gsub(" ", "-").downcase
  end

  def user_favorite_photo_url
    FLICKR_PHOTO_URLS[name] || "#{slug}.jpg"
  end

  def self.get_flickr_place_ids
    place_ids = {}
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_SHARED_SECRET"]
    Neighborhood.all.each do |neighborhood|
      sleep(0.1)
      flickr_places = flickr.places.find(:query => "#{neighborhood.name}, New York")
      if flickr_places
        flickr_places.each do |place|
          if has_photo?(place, neighborhood.name)
            place_ids[neighborhood.name] = place.place_id
            break
          end
        end
        place_ids[neighborhood.name] ||= "NO PICTURE FOUND"
      else
        place_ids[neighborhood.name] = "NO FLICKR PLACE FOUND"
      end
    end
    place_ids
  end

  def self.has_photo?(flickr_place, name)
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_SHARED_SECRET"]
    place_id = flickr_place.place_id
    sleep(0.1)
    photos = flickr.photos.search(:text => name, :place_id => place_id, :per_page => '1', :extras => 'url_o')
    if photos
      photos.each do |photo|
        if photo
          photo_url = photo["url_o"]
          return photo_url && (photo_url.size > 1)
        end
      end
    end
    return false
  end

  def self.get_photo_urls_from_place_ids
    photo_urls = {}
    Neighborhood.all.each do |neighborhood|
      photo_urls[neighborhood.name] = neighborhood.get_flickr
    end
    photo_urls
  end

  def self.get_neighborhoods_without_photos
    FLICKR_PHOTO_URLS.select{|name, url| url == nil}.keys
  end


  def get_google_directions(commute_address)
    origin = urlified_name + ",NY"
    destination = commute_address.gsub(" ", "+") + ",NY"

    "https://www.google.com/maps/embed/v1/directions?key=#{ENV["GMAPS_API_KEY"]}&origin=#{origin}&destination=#{destination}&mode=transit"
  end

end


