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

     # POST /answers/:id/answer_upvote
    def answer_upvote
      @answer = Answer.find(params[:id])
      @answer.answer_upvotes.create!(user:current_user)
      @answer.save
      redirect_back(fallback_location: root_path)  # 導回上一頁
    end



  private

  def answer_params
    params.require(:answer).permit(:content)
  end

end
