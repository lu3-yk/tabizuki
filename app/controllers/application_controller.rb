class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    # byebug
    @search = Tweet.ransack(params[:q])
    @search_tweet = @search.result.page(params[:page]).order(created_at: :desc) if params[:q]
  end
end
