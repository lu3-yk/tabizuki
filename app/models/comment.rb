class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one :activity, as: :subject, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 80 }

  after_create_commit :create_activities

  def name
    user.name
  end


  private
  def create_activities
    Activity.create(subject: self, user: tweet.user, action_type: :commented_to_tweet)
  end
end
