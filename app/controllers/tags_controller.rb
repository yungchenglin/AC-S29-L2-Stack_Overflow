class TagsController < ApplicationController
  before_action :find_tag , only: [:show]

  def index
    @tags = Tag.all
  end


  def search
    @tag = Tag.find_by(name: params[:search])
    if @tag
      @questions = @tag.questions
    else
      flash[:notice] = "The tag is not available..."
    end
  end

  def show
    @tagged_questions = @tag.questions
  end

  private
  def find_tag
    @tag = Tag.find(params[:id])
  end

end
