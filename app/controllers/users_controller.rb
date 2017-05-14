class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    logger.debug ">-----" + @user.inspect
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end


  def edit
    @user = User.find(params[:id])
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