class Answer < ApplicationRecord
  belongs_to :user
  has_many :answer_upvotes, dependent: :destroy
  has_many :upvote_users, through: :answer_upvotes, source: :user
end
