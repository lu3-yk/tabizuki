class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @commnet = Comment.find(params[:id])
    if @commnet.destroy
      redirect_to admin_tweet_path(@commnet.tweet.id)
    else

    end
  end
end
