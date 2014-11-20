class NeighborhoodsController < ApplicationController
    def index
        @neighborhoods = Neighborhood.all
        @neighborhood = Neighborhood.new
    end

    def show
        @neighborhood = Neighborhood.find(params[:id])
        @noko = @neighborhood.noko_listing
    end

    def create
        redirect_to neighborhood_path(params[:neighborhood][:id])
    end

end
