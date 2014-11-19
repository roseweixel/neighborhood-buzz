class Neighborhood < ActiveRecord::Base
  def index
    @neighborhoods = Neighborhood.all
  end
end
