class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user
      session[:user_id] = user.id
      redirect_to neighborhoods_path
    else
      flash[:notice] = "Could not find user!"
      redirect_to neighborhoods_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to neighborhoods_path
  end

end
