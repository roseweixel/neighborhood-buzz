class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :neighborhood
  validates :user_id, :neighborhood_id, presence: true
end
