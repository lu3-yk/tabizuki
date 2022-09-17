class Public::ActivitiesController < ApplicationController

  before_action :authenticate_user!

  def index
    activities = current_user.activities.order(created_at: :desc)
    activities_array = []
    activities.each do |activity|
      if activity.subject.user.id != current_user.id
        activities_array.push(activity)
      end
    end
    @activities = Kaminari.paginate_array(activities_array).page(params[:page]).per(8)
  end

  def read
    activity = current_user.activities.find(params[:id])
    unless activity.read?
      activity.update(read: true)
    end
    redirect_to activity.redirect_path
  end

end
