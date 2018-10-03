class AnswersController < ApplicationController
   before_action :redirect_to_sign_up_page
   
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
      @answer = Answer.find_by(id: params[:id])
      answerupvote = @answer.answer_upvotes.build(user_id: current_user.id)
      if answerupvote
        answerupvote.save
        flash[:notice] = "Vote Successfully !"
        redirect_back(fallback_location: root_path)  # 導回上一頁
      else
        flash[:alert] = @answer.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)  # 導回上一頁
      end  
      
    end

    def answer_downvote
      @answer = Answer.find_by(id: params[:id])
      @answerupvote = AnswerUpvote.find_by(user_id: current_user.id, answer_id: @answer.id)
      if @answerupvote
        @answerupvote.destroy
        flash[:notice] = "Downvote Successfully !"
        redirect_back(fallback_location: root_path)  # 導回上一頁
      else
        flash[:alert] = "You have to vote first before downvoting !"
        redirect_back(fallback_location: root_path)
      end
    end



  private

  def answer_params
    params.require(:answer).permit(:content)
  end

end
