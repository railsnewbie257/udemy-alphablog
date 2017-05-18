class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if (user && user.authenticate(params[:session][:password]))
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      if (!user)
        flash[:danger]="Please SIGNUP your email address"
      else
        flash.now[:danger] = "Email or password is incorrect"
      end
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end