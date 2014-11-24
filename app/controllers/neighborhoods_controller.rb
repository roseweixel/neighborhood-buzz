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
        @favorite_id = nil

        if session[:user_id]
            #binding.pry
            @user = User.find(session[:user_id])
            @user.favorites.each do |favorite|
               @favorite_id = favorite.id if favorite.neighborhood_id == @neighborhood.id
           end
        else
            @user = User.new
        end
    end

    def create
        redirect_to neighborhood_path(params[:neighborhood][:id])
    end

end
