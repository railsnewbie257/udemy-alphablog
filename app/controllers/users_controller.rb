class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :create, :update]
  before_action :require_same_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    logger.debug ">-----" + @user.inspect
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end


  def edit
  end

  def create
    if @user.save
      flash[:success] = "Your account was created successfully"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def update
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

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if @user != current_user
        flash[:danger]="You can only edit your own account"
        redirect_to root_path
      end
    end

end