class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.create(favorite_params)
    @favorite_id = @favorite.id
    respond_to do |f|
      f.js { }
      f.html { redirect_to neighborhood_path(favorite_params[:neighborhood_id]) }
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @neighborhood = @favorite.neighborhood
    @user = @favorite.user
    @favorite.destroy
    respond_to do |f|
      f.js { }
      f.html { redirect_to(:back) }
    end
  end

  private

    def favorite_params
      params.require(:favorite).permit(:user_id, :neighborhood_id)
    end
end