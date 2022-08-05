class Public::TweetsController < ApplicationController
  before_action :authenticate_user!
  def new
    @tweet = Tweet.new
  end

  # 投稿データの保存
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to tweets_path
  end

  def index
    @user = current_user
    @tweets = Tweet.all
  end

  def show
  end

  def edit
  end

  private
  # ストロングパラメータ
  def tweet_params
    params.require(:tweet).permit(:title, :body, :image)
  end
end
