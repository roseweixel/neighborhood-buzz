class Borough < ActiveRecord::Base
  has_many :neighborhoods
  has_many :user_borough_preferences
  has_many :users, through: :user_borough_preferences
end
