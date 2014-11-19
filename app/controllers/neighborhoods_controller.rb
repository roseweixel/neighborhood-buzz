class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.all
  end
end
