class Borough < ActiveRecord::Base
  has_many :neighborhoods
  has_many :user_boroughs
  has_many :users, through: :user_boroughs
end
