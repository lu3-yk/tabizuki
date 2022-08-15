class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end


  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    @user.tweets.destroy_all
    @user.comments.destroy_all
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:introduction)
  end

end
