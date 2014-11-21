class User < ActiveRecord::Base
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  before_save do
    self.slug = username.gsub(" ", "-").downcase
  end
 

  has_many :favorites
  has_many :neighborhoods, through: :favorites

  def self.find_by_slug(slug)
    User.all.find_by(slug: slug)
  end


  # def logged_in?
  #   if session[:user_id]
  #     return true
  #   else
  #     return false
  #   end
  # end
end
