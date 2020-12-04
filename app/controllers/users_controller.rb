class UsersController < ApplicationController
    before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path
    else
      render "edit"
    end
  end
  
  
  def following
    @user = User.find(params[:id])
    render "show_follow"
  end
  
  def followers
    @user = User.find(params[:id])
    render "show_follower"
  end
  
  
  protected
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  #https://qiita.com/ryuuuuuuuuuu/items/73cf2708b31c4cb901ec
  #何故かうまくいくからuserにもブチ込むといい感じ
  def correct_user
   @user = User.find(params[:id])
   if current_user != @user
    redirect_to user_path(current_user.id)
   end
  end
 
 
end
