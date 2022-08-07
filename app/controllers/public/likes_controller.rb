class Public::LikesController < ApplicationController

  def create
    tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.new(tweet_id: tweet.id)
    like.save
    redirect_to tweets_path
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.find_by(tweet_id: tweet.id)
    like.destroy
    redirect_to tweets_path
  end
end
