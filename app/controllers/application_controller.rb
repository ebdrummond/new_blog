class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    unless current_user
      flash[:notice] = "Whoopsidoodles!  Only Erin is allowed here."
      redirect_to root_path
    end
  end

  helper_method :current_user
end
