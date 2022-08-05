class Public::TweetsController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def create
  end

  def index
    @user = current_user
  end

  def show
  end

  def edit
  end
end
