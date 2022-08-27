class Prefecture < ApplicationRecord
  has_many :tweets
  has_ancestry

  def color
  end

  def hoverColor
  end
end
