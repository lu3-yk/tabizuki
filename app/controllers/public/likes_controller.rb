class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.new(tweet_id: @tweet.id)
    like.save
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.find_by(tweet_id: @tweet.id)
    like.destroy
  end
end
