class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :title ,:body,:introduction)
  end
end
