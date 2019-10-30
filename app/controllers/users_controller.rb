class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]
  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
       @user = User.find(params[:id])
  	if @user != current_user
       redirect_to user_path(@user.id)
    end
  end
  
  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id)
       flash[:notice] = "更新successfully"
    else
      @users = User.all
      @book = Book.new
      flash[:notice] = "error"
      render :index
    end
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  private 
  def user_params
   	params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    unless  params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
  end
 end
 end