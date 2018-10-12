class TagsController < ApplicationController
  def index
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
   
  end

end
