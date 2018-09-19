class AnswersController < ApplicationController

   def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Solution created."
    else
      flash[:alert] = "Please answer again."
    end
      redirect_back(fallback_location: questions_path)
  end


  private

  def answer_params
    params.require(:answer).permit(:content)
  end

end