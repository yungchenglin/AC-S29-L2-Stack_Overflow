class QuestionsController < ApplicationController


  
  def index
    @questions = Question.order(followers_count: :desc).limit(10)
  end

  def new
    @question = Question.new
  end


private






end
