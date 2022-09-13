class Public::ActivitiesController < ApplicationController

  before_action :authenticate_user!

  def index
    @activities = current_user.activities.order(created_at: :desc).page(params[:page]).per(20)
  end

  def read
    activity = current_user.activities.find(params[:id])
    unless activity.read?
      activity.update(read: true)
    end
    redirect_to activity.redirect_path
  end

end
