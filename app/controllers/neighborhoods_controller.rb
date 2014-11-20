class NeighborhoodsController < ApplicationController
    def index
        @neighborhoods = Neighborhood.all
    end

    def show
        @neighborhood = Neighborhood.find(params[:id])
        @noko = @neighborhood.noko_listing
    end

end
