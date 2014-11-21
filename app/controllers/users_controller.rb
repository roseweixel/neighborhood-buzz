class UsersController < ApplicationController
  def create
    @new_user = User.create(user_params)
    session[:user_id] = @new_user.id
    redirect_to neighborhoods_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email)
    end
end
