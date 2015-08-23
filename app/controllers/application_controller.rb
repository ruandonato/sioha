class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def require_login
    unless signed_in?
      flash[:danger] = "Esta ação requer que o usuário esteja logado."
      redirect_to signin_path
    end
  end

end


