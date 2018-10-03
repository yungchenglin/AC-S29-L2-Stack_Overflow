class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]


  mount_uploader :avatar, AvatarUploader
  
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :answer_upvotes, dependent: :destroy
  has_many :upvote_answers, through: :answer_upvotes, source: :answer
  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, source: :question
  has_many :question_upvotes, dependent: :destroy
  has_many :upvote_questions, through: :question_upvotes, source: :question

  def admin?
    self.role == "admin"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.email = auth.info.email
      user.avatar = auth.info.image if auth.info.image
      user.name = auth.info.name
      user.introduction = auth.info.description if auth.info.description
    end
  end
  

end
