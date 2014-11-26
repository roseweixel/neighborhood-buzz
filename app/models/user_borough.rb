class UserBorough < ActiveRecord::Base
  belongs_to :user
  belongs_to :borough
end
