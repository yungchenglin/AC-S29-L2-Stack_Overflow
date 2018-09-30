class Admin::QuestionsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin


  def index
    @users = User.all.order(created_at: :desc)
  end
  
  
end
