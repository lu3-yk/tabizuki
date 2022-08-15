class Public::TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parents, only: [:index, :new, :create, :edit, :update]

  def new
    @tweet = Tweet.new
  end

  # 投稿データの保存
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweets_path
    else
      render "new"
    end
  end

  def index
    respond_to do |format|
      format.html do
        @tweets = Tweet.all.order(created_at: :desc)
      end
      format.json do
        @children = Prefecture.find(params[:parent_id]).children
      end
    end
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
    if tweet.update(tweet_params)
      redirect_to tweet_path(tweet)
    else
      render"edit"
    end
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

  def search
    @prefecture = Prefecture.find_by(id: params[:id])
    if @prefecture.ancestry == nil
      prefecture = Prefecture.find_by(id: params[:id]).child_ids
      if prefecture.empty?
        @tweets = Tweet.where(prefecture_id: @prefecture.id).order(created_at: :desc)
        @tweets = @tweets.where(user_id: params[:user_id]) if params[:user_id]
      else
        @tweets = []
        find_item(prefecture)
      end

    elsif @prefecture
      @tweets = Tweet.where(prefecture_id: params[:id]).order(created_at: :desc)
      @tweets = @tweets.where(user_id: params[:user_id]) if params[:user_id]
    else
      prefecture = Prefecture.find_by(id: params[:id]).child_ids
      @tweets = []
      find_item(prefecture)
    end
  end

  def find_item(prefecture)
    prefecture.each do |id|
      tweet_array = Tweet.where(prefecture_id: id).order(created_at: :desc)
      if tweet_array.present?
        tweet_array.each do |tweet|
          if tweet.present?
            @tweets.push(tweet)
          end
        end
      end
    end
  end

  def get_prefecture_children
    @prefecture_children = Prefecture.find("#{params[:parent_id]}").children
    render json: @prefecture_children.map {|child| { id: child.id, name: child.name}}
  end

  private

  def set_parents
    @parents = Prefecture.where(ancestry: nil)
  end

  def tweet_params
    params.require(:tweet).permit(:title, :body, :image,:prefecture_id,)
  end

end