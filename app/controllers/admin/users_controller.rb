class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
    redirect_to admin_users_path, notice: 'guestuserはプロフィール編集画面へ遷移できません。' if @user.name == 'guestuser'
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render 'edit'
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    @user.tweets.destroy_all
    @user.comments.destroy_all
    flash[:notice] = '退会処理を実行いたしました'
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction)
  end
end
