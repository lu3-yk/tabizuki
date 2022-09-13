class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  has_one :activity, as: :subject, dependent: :destroy

  # userカラムは無いので、userで取得に来るコードは、Userモデルからデータをfindして返す。
  # そうすることで、get_profile_imageも一緒に使えるようになる。
  def user
    User.find(follower_id)
  end

  validates :follower_id, uniqueness: { scope: :followed_id }

  after_create_commit :create_activities

  def name
    follower.name
  end


  private
  def create_activities
    Activity.create(subject: self, user: followed, action_type: :followed_me)
  end

end
