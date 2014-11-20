require 'open-uri'
require 'date'

class Neighborhood < ActiveRecord::Base
  YELP_CONSUMER_KEY = "6_2-JlBlWrLhxpkGDCKZfA"
  YELP_CONSUMER_SECRET = "iQjeTUp-MR6MAlqMKnUTiEgGEJ4"
  YELP_TOKEN = "wzhKqRw5S7mkd4Ht4b9ekQ9-LMrY3bvp"
  YELP_TOKEN_SECRET = "yX5fI-fEpWd5hKerthzzwujq-7U"

  YELP_CLIENT = Yelp::Client.new({ consumer_key: YELP_CONSUMER_KEY,
                                consumer_secret: YELP_CONSUMER_SECRET,
                                token: YELP_TOKEN,
                                token_secret: YELP_TOKEN_SECRET
                              })

  SE_API_KEY = "a4e83294da970c9775f1b4e35dbbe1f87299c242"

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
    api_key = "019d22d7db27f8ef0242efc21d8d645e%3A19%3A70210388"
    type = "json"
    url = "http://api.nytimes.com/svc/real-estate/v2/listings/percentile/50.#{type}?date-range=#{get_year}-W#{get_week}&geo-extent-level=neighborhood&geo-extent-value=#{urlified_name}&api-key=#{api_key}"
    info_hash = JSON.load(open(url))
    info_hash["results"][0]["listing_price"]
  end


  def get_yelp_top_three_bars
    info = []
    params = { term: 'bar',
               limit: 3,
               sort: 2 # sort by rating
         }
    results = YELP_CLIENT.search(name, params).businesses
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
    results = YELP_CLIENT.search(name, params).businesses
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
      url = "http://streeteasy.com/nyc/api/rentals/data?criteria=area:#{urlified_name}-#{borough}\|new_developments:yes&key=#{SE_API_KEY}&format=json"
      encoded_url = URI.encode(url)
      info_hash = JSON.load(open(encoded_url))

      {median_price: info_hash["median_price"], search_url: info_hash["search_url"]}
  end

  def noko_listing
      se_hash = find_se_rentals
      ret_hash = {}
      listings_page = Nokogiri::HTML(open(se_hash[:search_url]))
      ret_hash[:img_url] = listings_page.css(".left-two-thirds .photo img").first.attributes["data-original"].value
      root_url = "http://streeteasy.com"
      append_url = listings_page.css(".details-title a").first.attributes["href"].value
      ret_hash[:listing_url] = root_url + append_url
      ret_hash[:monthly_rent] = listings_page.css(".price").first.children.text
      ret_hash[:seach_url] = se_hash[:search_url]
      ret_hash
  end


end
