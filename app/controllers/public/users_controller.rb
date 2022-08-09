class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:likes]
  
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
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

  def likes
    likes = Like.where(user_id: @user.id).pluck(:tweet_id)
    @like_tweets = Tweet.find(likes)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :title ,:body,:introduction)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
