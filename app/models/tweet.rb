class Tweet < ApplicationRecord
  has_one_attached :image
  belongs_to :user


  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_img.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/jpeg')
    end
    image
  end

end
