class SessionsController < ApplicationController
  # def create
  #   user = User.find_by(slug: sluggify(params[:username]))
  #   if user
  #     session[:user_id] = user.id
  #     redirect_to root_path
  #   else
  #     flash[:notice] = "Could not find user!"
  #     redirect_to root_path
  #   end
  # end
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:notice] = "Successfully signed in with Facebook!"
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end

end
