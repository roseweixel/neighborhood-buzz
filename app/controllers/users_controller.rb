class UsersController < ApplicationController
  def create
    if User.find_by(:email => user_params[:email])
      flash[:notice] = "Someone with this email has already signed up!"
      redirect_to neighborhoods_path
      return
    elsif User.find_by(:username => user_params[:username])
      flash[:notice] = "Sorry, this username is taken!"
      redirect_to neighborhoods_path
      return
    end
    @new_user = User.new(user_params)
    if @new_user.save
      flash[:notice] = "Successfully signed up!"
      session[:user_id] = @new_user.id
    else
      flash[:notice] = "Must enter a valid username and email!"
    end 
    redirect_to neighborhoods_path
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:username, :email)
    end
end
