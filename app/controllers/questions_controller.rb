class QuestionsController < ApplicationController
  before_action :set_question, only: []


  
  def index
     @questions = Question.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @question = Question.new
  end

  def create
    @user = current_user
    @question = current_user.questions.build(question_params)

    if @question.save
      flash[:notice] = "Question Update"
      redirect_to questions_path
    else
      flash.now[:alert] = @Question.errors.full_messages.to_sentence
      render :new
    end
  end
  
  def show
    @question = Question.find_by(id: params[:id])
    @answers = @question.answers.order(created_at: :asc)
    @answer = Answer.new
  end

  # POST /questions/:id/favorite
  def favorite
    @question = Question.find(params[:id])
    @question.favorites.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unfavorite
    @question = Question.find(params[:id])
    favorites = Favorite.where(question: @question, user: current_user)
    favorites.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end
  
private

  def set_question
    @question = question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :description)
  end



end

