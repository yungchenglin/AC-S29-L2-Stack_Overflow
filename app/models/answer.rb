class Answer < ApplicationRecord
  belongs_to :user, counter_cache: :answers_count
  belongs_to :question
  has_many :answer_upvotes, dependent: :destroy
  has_many :upvote_users, through: :answer_upvotes, source: :user
end
