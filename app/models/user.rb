class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :answer_upvotes, dependent: :destroy
  has_many :upvote_answers, through: :answer_upvotes, source: :answer
  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, source: :question
  has_many :question_upvotes, dependent: :destroy
  has_many :upvote_questions, through: :question_upvotes, source: :question
end
