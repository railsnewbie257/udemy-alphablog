class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    logger.debug ">-----" + @user.inspect
  end

  def index
    @users = User.paginate(page: params[:page])
  end


  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Your account was created successfully"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def update
    if (@user.id == current_user.id)
      flash[:danger]="You can not delete yourself"
      redirect_to root_path
    end
    if (@user.update(user_params))
      flash[:success] = "You account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger]= "User and all articles created by user have been deleted"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
      logger.debug "----- set_user -----"
    end

    def require_same_user
      if @user != current_user and !current_user.admin?
        flash[:danger]="You can only edit your own account"
        redirect_to root_path
      end
    end

    def require_admin
      if (logged_in? and !current_user.admin?)
        flash[:danger]="You must be an admin"
        redirect_to root_path
      end
    end

end