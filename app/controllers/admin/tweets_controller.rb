class Admin::TweetsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_user_path(@tweet.user.id)
  end

end
