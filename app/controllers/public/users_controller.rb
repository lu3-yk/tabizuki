class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def edit
  end

  def update
  end
end
