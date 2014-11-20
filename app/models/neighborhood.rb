require 'open-uri'
require 'date'

class Neighborhood < ActiveRecord::Base

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

  def get_yelp
    consumer_key = "6_2-JlBlWrLhxpkGDCKZfA"
    consumer_secret = "iQjeTUp-MR6MAlqMKnUTiEgGEJ4"
    token = "wzhKqRw5S7mkd4Ht4b9ekQ9-LMrY3bvp"
    token_secret = "yX5fI-fEpWd5hKerthzzwujq-7U"
  end

 

end
