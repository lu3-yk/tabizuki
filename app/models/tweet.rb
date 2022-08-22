class Tweet < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :prefecture
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  # バリデーション
  validates :image,         presence: true
  validates :title,         presence: true, length: { maximum: 30 }
  validates :body,          presence: true, length: { maximum: 300 }

  # Likesテーブル内に存在（exists?）するか
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_img.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end
end
