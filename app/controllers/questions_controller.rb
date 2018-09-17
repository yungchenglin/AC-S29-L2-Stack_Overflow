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
  end



   
private

  def set_question
    @question = question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :description)
  end



end

