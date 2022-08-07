class Prefecture < ApplicationRecord
   has_many :tweets, dependent: :destroy
end
