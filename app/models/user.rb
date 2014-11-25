class User < ActiveRecord::Base
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  before_save do
    self.slug = username.gsub(" ", "-").downcase
  end

  NULL_ATTRS = %w( commute_address commute_city )
  before_save :nil_if_blank

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end
 
  has_many :favorites
  has_many :neighborhoods, through: :favorites

  def self.find_by_slug(slug)
    User.all.find_by(slug: slug)
  end

  def get_favorite_by_neighborhood(neighborhood)
    favorites.find{|favorite| favorite.neighborhood_id == neighborhood.id}
  end

  def average_price_of_favorites
    prices = neighborhoods.map{|neighborhood| neighborhood.median_buy_price}
    sum = prices.inject(:+)
    average = sum / prices.size
    average.round
  end

  def average_price_string
    formatted_string = "$"
    formatted_array = []
    unformatted_string = average_price_of_favorites.to_s
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

  def similar_to_favorites_by_price
    delta = average_price_of_favorites / 20
    results = Neighborhood.select{|neighborhood| neighborhood.median_buy_price.between?((average_price_of_favorites - delta), (average_price_of_favorites + delta)) && !self.neighborhoods.include?(neighborhood)}
    results
  end


  # def logged_in?
  #   if session[:user_id]
  #     return true
  #   else
  #     return false
  #   end
  # end
end
