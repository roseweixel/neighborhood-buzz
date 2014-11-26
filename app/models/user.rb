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

  def average_buy_price_of_favorites
    prices = neighborhoods.map{|neighborhood| neighborhood.median_buy_price}
    sum = prices.inject(:+)
    average = sum / prices.size
    average.round
  end

  def average_rent_price_of_favorites
    prices = neighborhoods.map{|neighborhood| neighborhood.median_rental_price_integer}
    sum = prices.inject(:+)
    average = sum / prices.size
    average.round
  end

  def average_price_string(price_int)
    formatted_string = "$"
    formatted_array = []
    unformatted_string = price_int.to_s
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

  def similar_to_favorites_buy_price
    delta = average_buy_price_of_favorites / 20
    results = Neighborhood.select{|neighborhood| neighborhood.median_buy_price.between?((average_buy_price_of_favorites - delta), (average_buy_price_of_favorites + delta)) && !self.neighborhoods.include?(neighborhood)}
    results
  end

  def similar_to_favorites_rent_price
    delta = average_rent_price_of_favorites / 20
    results = Neighborhood.select{|neighborhood| neighborhood.median_buy_price.between?((average_rent_price_of_favorites - delta), (average_rent_price_of_favorites + delta)) && !self.neighborhoods.include?(neighborhood)}
    results
  end

  # median_rental_price_integer


  # def logged_in?
  #   if session[:user_id]
  #     return true
  #   else
  #     return false
  #   end
  # end
end
