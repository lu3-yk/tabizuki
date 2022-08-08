class Public::CommentsController < ApplicationController

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.new
    comment = current_user.comments.new(comment_params)
    comment.tweet_id = @tweet.id
    unless comment.save
      redirect_to tweet_path(@tweet)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end


end