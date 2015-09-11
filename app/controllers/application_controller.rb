# File: application_controller.rb.
# Purpose: 
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

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

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end

end


