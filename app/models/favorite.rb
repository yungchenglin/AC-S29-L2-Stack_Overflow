class Favorite < ApplicationRecord
  belongs_to :user, counter_cache: :favorites_count
  belongs_to :question
end
