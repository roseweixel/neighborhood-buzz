require 'open-uri'

class Neighborhood < ActiveRecord::Base

# API_KEY = 019d22d7db27f8ef0242efc21d8d645e:19:70210388
    API_KEY = "019d22d7db27f8ef0242efc21d8d645e%3A19%3A70210388"

    def urlified_name
        name.gsub(" ", "+")
    end

    def find_neighborhood_percentile
        type = "json"
        url = "http://api.nytimes.com/svc/real-estate/v2/listings/percentile/50.#{type}?date-range=2014-10&geo-extent-level=neighborhood&geo-extent-value=#{urlified_name}&api-key=#{API_KEY}"
        info_hash = JSON.load(open(url))
        puts info_hash.inspect
    end
 

end
