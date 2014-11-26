class UsersController < ApplicationController
  def create
    if User.find_by(:email => user_params[:email])
      flash[:notice] = "Someone with this email has already signed up!"
      redirect_to(:back)
      return
    elsif User.find_by(:username => user_params[:username])
      flash[:notice] = "Sorry, this username is taken!"
      redirect_to(:back)
      return
    end
    @new_user = User.new(user_params)
    if @new_user.save
      flash[:notice] = "Successfully signed up!"
      session[:user_id] = @new_user.id
    else
      flash[:notice] = "Must enter a valid username and email!"
    end 
    redirect_to(:back)
  end

  def show
    @user = User.find(params[:id])
    @rental_counter = 0
    @buying_counter = 0
  end

  def edit
    @user = User.find(params[:id])
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

  def update
    #binding.pry
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to(:back)
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :commute_address, :commute_city, :want_to_rent, :want_to_buy, :min_rent_price, :max_rent_price, :min_buy_price, :max_buy_price, :likes_manhattan, :likes_brooklyn, :likes_queens)
    end
end
