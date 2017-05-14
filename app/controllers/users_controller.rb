class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
  end

  def create
    debugger
    @user = User.create(params[:id])
    if @user.save
      flash[:success] = "Your account was created successfully"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if (@user.update(user_params))
      flash[:success] = "You account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end