class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
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
    if (@user.id && @user.update(user_params))
      flash[:success] = "You account was updated successfully"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy && current_user.id != @user.id
      flash[:danger]= "User and all articles created by user have been deleted"
      redirect_to users_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
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