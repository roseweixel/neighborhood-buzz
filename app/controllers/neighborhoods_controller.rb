class NeighborhoodsController < ApplicationController
    def index
        @manhattan_neighborhoods = Borough.find_by(name: "Manhattan").neighborhoods
        @brooklyn_neighborhoods = Borough.find_by(name: "Brooklyn").neighborhoods
        @queens_neighborhoods = Borough.find_by(name: "Queens").neighborhoods
        @neighborhood = Neighborhood.new
        if session[:user_id]
            @user = User.find(session[:user_id])
        else
            @user = User.new
        end
        if @user.commute_address
            @commute_place = @user.commute_address
            @address_value = :value
        else
            @commute_place = "e.g. 11 Broadway"
            @commute_value = :placeholder
        end
        if @user.commute_city
            @city = @user.commute_city
            @city_value = :value
        else
            @city = "e.g. New York"
            @city_value = :placeholder
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
