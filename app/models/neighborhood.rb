require 'open-uri'
require 'date'
require 'flickr.rb'

class Neighborhood < ActiveRecord::Base
  has_many :favorites
  has_many :users, through: :favorites

  # before_save do
  #   self.median_buy_price = median_buy_price
  # end

  FLICKR_PHOTO_URLS = {"Battery Park City"=>"https://farm8.staticflickr.com/7572/15789431221_efb889cc87_o.jpg", "Carnegie Hill"=>nil, "Chelsea"=>"https://farm6.staticflickr.com/5591/14612145143_6c8d752962_o.jpg", "East Harlem"=>"https://farm4.staticflickr.com/3956/15710616486_ca03e3cc11_o.jpg", "East Village"=>"https://farm8.staticflickr.com/7531/15652935040_31dfe1b39c_o.jpg", "Financial District"=>"https://farm9.staticflickr.com/8643/15658301788_3274afb0e5_o.jpg", "Flatiron"=>"https://farm6.staticflickr.com/5609/15212523974_a3bbf751dc_o.jpg", "Gramercy"=>"https://farm6.staticflickr.com/5605/15623224390_6cf407787b_o.jpg", "Hamilton Heights"=>"https://farm4.staticflickr.com/3936/15238358359_855d1afd07_o.jpg", "Harlem"=>"https://farm9.staticflickr.com/8627/15837845352_dd716a4acb_o.jpg", "Hudson Heights"=>"https://farm8.staticflickr.com/7545/15650588707_ef310446dd_o.jpg", "Inwood"=>"https://farm8.staticflickr.com/7486/15849568861_8c677a84f4_o.jpg", "Kips Bay"=>nil, "Lower East Side"=>"https://farm8.staticflickr.com/7474/15229535284_abdb3ef723_o.jpg", "Manhattan Valley"=>nil, "Midtown East"=>"https://farm5.staticflickr.com/4100/4811604391_9eae8513cb_o.jpg", "Midtown West"=>nil, "Morningside Heights"=>"https://farm8.staticflickr.com/7533/15195746444_8ac8f34c09_o.jpg", "Mt. Morris Park"=>"https://farm6.staticflickr.com/5480/9477235684_6e6c846d3f_o.jpg", "Murray Hill"=>"https://farm8.staticflickr.com/7537/15806188391_7b4e1727e1_o.jpg", "NoHo"=>"https://farm6.staticflickr.com/5054/5508008968_10552b2466_o.jpg", "Roosevelt Island"=>"https://farm6.staticflickr.com/5608/15199769404_21abfda85f_o.jpg", "Seaport"=>"https://farm6.staticflickr.com/5608/15629355907_f089f5ce07_o.jpg", "Soho"=>"https://farm8.staticflickr.com/7485/15228529423_b27917ece9_o.jpg", "Sugar Hill"=>"https://farm4.staticflickr.com/3919/15068216178_ff2cec9a6f_o.jpg", "Tribeca"=>"https://farm8.staticflickr.com/7568/15188408743_4762c45170_o.jpg", "Union Square"=>"https://farm9.staticflickr.com/8599/15227059093_8e542fd539_o.jpg", "Upper East Side"=>"https://farm9.staticflickr.com/8620/15827887175_2d70f03ff2_o.jpg", "Upper West Side"=>"https://farm8.staticflickr.com/7534/15234794043_d9e5f3d9f4_o.jpg", "Village"=>nil, "Washington Heights"=>"https://farm8.staticflickr.com/7572/15827633516_cfe5ac4018_o.jpg", "West Village"=>"https://farm8.staticflickr.com/7563/15639255409_13270366dd_o.jpg", "Arverne"=>"https://farm4.staticflickr.com/3934/14991365893_5fed59f9e8_o.jpg", "Astoria"=>"https://farm8.staticflickr.com/7499/15668036317_5f6a03207a_o.jpg", "Bayside"=>"https://farm4.staticflickr.com/3935/15654117775_0257ba3584_o.jpg", "Beechhurst"=>nil, "Bellerose"=>nil, "Breezy Point"=>"https://farm6.staticflickr.com/5571/14996703090_170dd7782d_o.jpg", "Briarwood"=>nil, "Broad Channel"=>"https://farm8.staticflickr.com/7481/15067316744_57d0fe8084_o.jpg", "Cambria Heights"=>nil, "College Point"=>"https://farm3.staticflickr.com/2945/15290674540_9368353571_o.jpg", "Corona"=>"https://farm9.staticflickr.com/8561/15651221040_f68504ba75_o.jpg", "Douglaston"=>"https://farm6.staticflickr.com/5497/14541324886_c6901685e6_o.jpg", "East Elmhurst"=>"https://farm4.staticflickr.com/3945/15049051634_6bd573d1c0_o.jpg", "Elmhurst"=>"https://farm8.staticflickr.com/7547/15821002576_5e9e1ac600_o.jpg", "Far Rockaway"=>nil, "Floral Park"=>"https://farm8.staticflickr.com/7477/15497783437_d9a94d4822_o.jpg", "Flushing"=>"https://farm8.staticflickr.com/7557/15660804019_11dedcbe6b_o.jpg", "Forest Hills"=>"https://farm6.staticflickr.com/5603/15648118289_2728f92895_o.jpg", "Fresh Meadows"=>"https://farm6.staticflickr.com/5496/12296668594_3720da49da_o.jpg", "Glen Oaks"=>"https://farm4.staticflickr.com/3931/15509886155_20186457f2_o.jpg", "Glendale"=>"https://farm4.staticflickr.com/3932/15441755295_393f0be847_o.jpg", "Hollis"=>"https://farm4.staticflickr.com/3899/14519057848_614eeedfa0_o.jpg", "Howard Beach"=>"https://farm4.staticflickr.com/3939/15625530762_c525b710ed_o.jpg", "Jackson Heights"=>"https://farm8.staticflickr.com/7565/15848782252_1a03febff1_o.jpg", "Jamaica"=>"https://farm8.staticflickr.com/7539/15851888252_c1e4b14634_o.jpg", "JFK Airport"=>"https://farm8.staticflickr.com/7470/15851879222_4db54161eb_o.jpg", "Kew Gardens"=>"https://farm8.staticflickr.com/7347/13070128634_fcbf847e02_o.jpg", "Kew Gardens Hills"=>"https://farm6.staticflickr.com/5587/15169690242_b11823e217_o.jpg", "Little Neck"=>"https://farm4.staticflickr.com/3912/14193877190_4a8fed5d8d_o.jpg", "Long Island City"=>"https://farm9.staticflickr.com/8591/15852038092_f8339743f2_o.jpg", "Maspeth"=>"https://farm6.staticflickr.com/5600/15536467102_9074f45e0d_o.jpg", "Middle Village"=>"https://farm9.staticflickr.com/8620/15827887175_2d70f03ff2_o.jpg", "Ozone Park"=>"https://farm4.staticflickr.com/3853/14839346939_b47de76210_o.jpg", "Queens Village"=>"https://farm4.staticflickr.com/3947/15576623757_694fe40066_o.jpg", "Rego Park"=>nil, "Richmond Hill"=>nil, "Ridgewood"=>"https://farm8.staticflickr.com/7578/15647995329_4f0e6364a0_o.jpg", "Rockaway Park"=>"https://farm6.staticflickr.com/5611/15790797241_95c941c9f8_o.jpg", "Rosedale"=>"https://farm3.staticflickr.com/2835/12820070165_4c5b05f9a5_o.jpg", "South Jamaica"=>"https://farm6.staticflickr.com/5556/14978902515_549b0b0fb8_o.jpg", "South Ozone Park"=>"https://farm4.staticflickr.com/3910/14839346029_a5cf806588_o.jpg", "Springfield Gardens"=>"https://farm8.staticflickr.com/7429/13110480393_1f47c78069_o.jpg", "St. Albans"=>"https://farm4.staticflickr.com/3796/9571325978_54bb52d173_o.jpg", "Sunnyside"=>"https://farm8.staticflickr.com/7477/15844801031_daa3026f83_o.jpg", "Utopia"=>"https://farm3.staticflickr.com/2823/9043335803_0e51525376_o.jpg", "Whitestone"=>"https://farm8.staticflickr.com/7557/15748083845_a91664dbb1_o.jpg", "Woodhaven"=>"https://farm6.staticflickr.com/5597/15083725443_36ddff60fc_o.jpg", "Woodside"=>"https://farm9.staticflickr.com/8656/15821092726_b8e4c3c644_o.jpg", "Bath Beach"=>"https://farm4.staticflickr.com/3745/14246119816_32989c1230_o.jpg", "Bay Ridge"=>"https://farm8.staticflickr.com/7530/15775153135_110cd68265_o.jpg", "Bedford Stuyvesant"=>"https://farm3.staticflickr.com/2943/15179149430_bd74a66210_o.jpg", "Bensonhurst"=>"https://farm8.staticflickr.com/7520/15582881878_2ceac3a591_o.jpg", "Bergen Beach"=>"https://farm8.staticflickr.com/7525/15852217512_b7afd3a6c4_o.jpg", "Boerum Hill"=>nil, "Borough Park"=>"https://farm8.staticflickr.com/7472/15621595610_03d48567bf_o.jpg", "Brighton Beach"=>"https://farm8.staticflickr.com/7482/15177283594_9f7103b7f0_o.jpg", "Brooklyn Heights"=>"https://farm9.staticflickr.com/8639/15668722387_8cc839bd8b_o.jpg", "Brownsville"=>"https://farm4.staticflickr.com/3944/15372482937_233cfb09a9_o.jpg", "Bushwick"=>"https://farm9.staticflickr.com/8593/15783231756_ef788dde08_o.jpg", "Canarsie"=>"https://farm6.staticflickr.com/5580/14898681798_ae5f7c54bb_o.jpg", "Carroll Gardens"=>nil, "Clinton Hill"=>nil, "Cobble Hill"=>"https://farm6.staticflickr.com/5609/15461046940_3442cbc036_o.jpg", "Coney Island"=>"https://farm8.staticflickr.com/7499/15853791612_379f08ebbe_o.jpg", "Crown Heights"=>"https://farm8.staticflickr.com/7522/15583924189_372062fdd9_o.jpg", "Ditmas Park"=>nil, "Dumbo"=>"https://farm8.staticflickr.com/7474/15229535284_abdb3ef723_o.jpg", "Dyker Heights"=>"https://farm4.staticflickr.com/3949/15437633539_780180a04a_o.jpg", "East New York"=>"https://farm8.staticflickr.com/7576/15828007286_bb4573daef_o.jpg", "Flatbush"=>"https://farm8.staticflickr.com/7499/15668036317_5f6a03207a_o.jpg", "Flatlands"=>"https://farm8.staticflickr.com/7499/15668036317_5f6a03207a_o.jpg", "Fort Greene"=>"https://farm6.staticflickr.com/5602/15610949859_e523b85894_o.jpg", "Fort Hamilton"=>"https://farm4.staticflickr.com/3951/14960892693_f9ab503f21_o.jpg", "Gravesend"=>"https://farm4.staticflickr.com/3894/14929018269_1f856ac210_o.jpg", "Greenpoint"=>"https://farm6.staticflickr.com/5607/15186597593_3e21e8b7fb_o.jpg", "Kensington"=>"https://farm8.staticflickr.com/7509/15718278456_a867f4b5f4_o.jpg", "Manhattan Beach"=>"https://farm9.staticflickr.com/8537/15177203823_35deaffaa9_o.jpg", "Midwood"=>"https://farm6.staticflickr.com/5616/15575645045_826d5b1e7e_o.jpg", "Mill Basin"=>nil, "Navy Yard"=>"https://farm8.staticflickr.com/7497/15039357773_4ef0f785fb_o.jpg", "Ocean Hill"=>"https://farm4.staticflickr.com/3929/15340315669_38d1650f90_o.jpg", "Park Slope"=>nil, "Prospect Heights"=>"https://farm8.staticflickr.com/7479/15668692407_285607c988_o.jpg", "Prospect Lefferts Gardens"=>nil, "Red Hook"=>"https://farm6.staticflickr.com/5614/15643321238_de482c6565_o.jpg", "Sheepshead Bay"=>"https://farm6.staticflickr.com/5597/15576435836_94995609c1_o.jpg", "Spring Creek"=>nil, "Starrett City"=>"https://farm6.staticflickr.com/5614/15072927104_48a5274115_o.jpg", "Sunset Park"=>nil, "Vinegar Hill"=>"https://farm6.staticflickr.com/5606/15343709937_5249c8c044_o.jpg", "Williamsburg"=>"https://farm8.staticflickr.com/7505/15234343593_4a42da7e17_o.jpg", "Windsor Terrace"=>"https://farm6.staticflickr.com/5598/15564880711_b7e602a738_o.jpg"}

  FLICKR_API_KEY = "cdbc2d25078495e755c6fd7fd8b6f4dd"
  FLICKR_SHARED_SECRET = "294b090c6cbc2c6e"

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

  GMAPS_API_KEY = "AIzaSyBhfTB3RhPILdH4bQREQBQtMEixEltLZyY"

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
      ret_hash[:search_url] = se_hash[:search_url]
      ret_hash
  end

  def twitterified_name
    new_name = name.gsub(" ", "")
    # new_name + "nyc"
  end

  def get_tweets
    api_key = "N1cBxsbxHoImqQp1bikNXmoZh"
    consumer_secret = "zBeYHbAOsXBxEN8y9X3t5TtB5GMZwgSLJM8cviTlebH9NmmSOn"
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = api_key
      config.consumer_secret     = consumer_secret
    end
    tweets = []
    client.search("##{twitterified_name} #nyc").each do |tweet|
      tweets << tweet
      if tweets.count == 5
        return tweets
      end
    end
  end

  def get_flickr
    FlickRaw.api_key = FLICKR_API_KEY
    FlickRaw.shared_secret = FLICKR_SHARED_SECRET
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
    FlickRaw.api_key = FLICKR_API_KEY
    FlickRaw.shared_secret = FLICKR_SHARED_SECRET
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
    FlickRaw.api_key = FLICKR_API_KEY
    FlickRaw.shared_secret = FLICKR_SHARED_SECRET
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
    url = "https://www.google.com/maps/embed/v1/directions?key=#{GMAPS_API_KEY}&origin=#{origin}&destination=#{destination}&mode=transit"
  end


end



