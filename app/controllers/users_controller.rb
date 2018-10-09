class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @user
      @user.update!(user_proflie_params)
      flash[:notice] = "Your Profile Has Been Updated !"
      redirect_to user_path(@user)
    else
      flash[:alert] = "User is not found ! Please try again..."
      redirect_back(fallback_location: root_path)
    end
  end
 
  def destroy
    @user.destroy
    flash[:alert] = "User was deleted."
    redirect_to root_path
  end

  private
  
  def user_proflie_params
    params.require(:user).permit(:name, :company, :title, :website, :twitter, :github, :introduction, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
