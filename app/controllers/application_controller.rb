# File: application_controller.rb.
# Purpose: Allow the integration between controllers and views
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class ApplicationController < ActionController::Base
  # prevent CSRF attacks by raising an exception.
  # for APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper


  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  rescue_from ActionController::RoutingError, :with => :routes_not_found

  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def routes_not_found
    respond_to do |f|
      f.html{ render :template => "errors/404", :status => 404}
    end
  end

  def render_not_found
    respond_to do |f|
      f.html{ render :template => "errors/500", :status => 500}
    end
  end

  # this method will redirect users who are not logged
  private

  def require_login
    unless signed_in?
      flash[:danger] = "Esta ação requer que o usuário esteja logado."
      redirect_to signin_path
    end
  end

  # this method will redirect the user to the main page if the filter does not pass
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end

end
