require 'open-uri'
require 'date'

class Neighborhood < ActiveRecord::Base

# API_KEY = "019d22d7db27f8ef0242efc21d8d645e:19:70210388"
    API_KEY = "019d22d7db27f8ef0242efc21d8d645e%3A19%3A70210388"
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
        type = "json"
        url = "http://api.nytimes.com/svc/real-estate/v2/listings/percentile/50.#{type}?date-range=#{get_year}-W#{get_week}&geo-extent-level=neighborhood&geo-extent-value=#{urlified_name}&api-key=#{API_KEY}"
        info_hash = JSON.load(open(url))
        info_hash["results"][0]["listing_price"]
    end
 
    def find_se_rentals
        url = "http://streeteasy.com/nyc/api/rentals/data?criteria=area:#{urlified_name}-#{borough}\|beds:2&key=#{SE_API_KEY}&format=json"
        encoded_url = URI.encode(url)
        info_hash = JSON.load(open(encoded_url))
  
        {median_price: info_hash["median_price"], search_url: info_hash["search_url"]}
    end


end
