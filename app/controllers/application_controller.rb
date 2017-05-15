class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      @current_user = User.first
      session[:user_id] = @current_user.id;
      redirect_to root_path
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
      if !logged_in?
        flash[:danger]="You must be logged in to perform that action"
        redirect_to root_path
      end
  end

end
