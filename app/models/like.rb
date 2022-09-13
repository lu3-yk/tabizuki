class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  def name
    user.name
  end

  private
  def create_activities
    Activity.create(subject: self, user: self.tweet.user, action_type: :liked_to_tweet)
  end

end
