class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @tweets = Tweet.all.order(created_at: :desc)
    # redirect_to request.referer
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    @tweets = Tweet.all.order(created_at: :desc)
    # redirect_to request.referer
  end

end
