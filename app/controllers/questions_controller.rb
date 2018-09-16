class QuestionsController < ApplicationController


  
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
      flash[:notice] = "Question was successfully created"
      redirect_to questions_url
    else
      flash.now[:alert] = "Question was failed to create"
      render :new
    end
  end

   
private

  def question_params
    params.require(:question).permit(:title, :description)
  end



end

