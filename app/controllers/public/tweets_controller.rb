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
    @tweets = Tweet.all

  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to tweet_path(tweet)
  end


  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    # 遷移前のURLがtweetの詳細pageの場合
    if request.referer.include?("/tweets/#{@tweet.id}")
      redirect_to user_path(current_user.id)
    else
      redirect_to tweets_path
    end
  end



  private

  def tweet_params
    params.require(:tweet).permit(:title, :body, :image,:prefecture_id)
  end
end
