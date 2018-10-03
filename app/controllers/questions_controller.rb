class QuestionsController < ApplicationController
  before_action :redirect_to_sign_up_page, only: [:create, :favorite, :unfavorite, :question_upvote, :question_downvote]
  before_action :set_question, only: [:show, :favorite, :unfavorite, :question_upvote, :question_downvote]


  
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
      flash.now[:alert] = @question.errors.full_messages.to_sentence
      render :new
    end
  end
  
  def show
    #@question = Question.find_by(id: params[:id]) 加入before_action預先執行
    @answers = @question.answers.order(created_at: :asc)
    @answer = Answer.new
  end

  # POST /questions/:id/favorite
  def favorite
    @question.favorites.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def unfavorite
    favorites = Favorite.where(question: @question, user: current_user)
    favorites.destroy_all
    redirect_back(fallback_location: root_path)
  end

  # POST /questions/:id/question_upvote
  def question_upvote
    @question.question_upvotes.create!(user: current_user)
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  # DELETE /questions/:id/question_downvote
  def question_downvote
    @questionupvote = QuestionUpvote.find_by(question_id: @question.id, user_id: current_user.id)
    if  @questionupvote
        @questionupvote.destroy
        flash[:notice] = "Downvote Successfully !"
        redirect_back(fallback_location: root_path)  # 導回上一頁
    else
        flash[:alert] = "You have to vote first before downvoting !"
    end
  end

  
   
private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :description)
  end
  
  def redirect_to_sign_up_page
    if !user_signed_in?
      redirect_to new_user_registration_path
    end
  end


end

