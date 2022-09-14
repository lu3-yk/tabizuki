class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy]
  before_action :set_user, only: [:likes]
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_parents, only: :show

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(8)
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
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
    like_tweets = Tweet.find(likes)
    @like_tweets = Kaminari.paginate_array(like_tweets).page(params[:page]).per(8)
  end

  def unsubscribe
    @user = current_user
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    @user.tweets.destroy_all
    @user.comments.destroy_all
    @user.follower.destroy_all
    @user.followed.destroy_all
    @user.likes.destroy_all
    reset_session
    flash[:notice] = 'ご利用ありがとうございました。'
    redirect_to root_path
  end

  def set_parents
    @parents = Prefecture.where(ancestry: nil)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to tweets_path if @user != current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :title, :body, :introduction, :email, :passward)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user), notice: 'guestuserはプロフィール編集画面へ遷移できません。' if @user.name == 'guestuser'
  end
end
