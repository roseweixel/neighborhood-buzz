class FavoritesController < ApplicationController
  def create
    Favorite.create(favorite_params)
    redirect_to neighborhood_path(favorite_params[:neighborhood_id])
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @neighborhood_id = @favorite.neighborhood_id
    @favorite.destroy
    redirect_to neighborhood_path(@neighborhood_id)
  end

  private

    def favorite_params
      params.require(:favorite).permit(:user_id, :neighborhood_id)
    end
end