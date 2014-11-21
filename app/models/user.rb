class User < ActiveRecord::Base
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  has_many :favorites
  has_many :neighborhoods, through: :favorites

  # def logged_in?
  #   if session[:user_id]
  #     return true
  #   else
  #     return false
  #   end
  # end
end
