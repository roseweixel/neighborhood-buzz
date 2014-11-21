class NeighborhoodsController < ApplicationController
    def index
        @neighborhoods = Neighborhood.all
        @neighborhood = Neighborhood.new
        if session[:user_id]
            @user = User.find(session[:user_id])
        else
            @user = User.new
        end
    end

    def show
        @neighborhood = Neighborhood.find(params[:id])
        @noko = @neighborhood.noko_listing
        if session[:user_id]
            @user = User.find(session[:user_id])
        else
            @user = User.new
        end
    end

    def create
        redirect_to neighborhood_path(params[:neighborhood][:id])
    end

end
