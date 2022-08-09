class Prefecture < ApplicationRecord
   has_many :tweets, dependent: :destroy
   has_ancestry
end
