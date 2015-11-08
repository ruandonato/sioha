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

  # rescues the method "render_not_found" for RecordNotFound erros
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  # rescues the method "routes_not_found" for RoutingError
  rescue_from ActionController::RoutingError, :with => :routes_not_found

  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  # action that renders the error page 404
  def routes_not_found
    respond_to do |f|
      f.html{ render :template => "errors/404", :status => 404}
    end
  end

  # action that renders the error page 500
  def render_not_found
    respond_to do |f|
      f.html{ render :template => "errors/500", :status => 500}
    end
  end

  # this method will redirect users who are not logged
  private

  def require_login
    if signed_in? == false
      flash[:danger] = "Esta ação requer que o usuário esteja logado."
      redirect_to signin_path
    else
      # nothing to do
    end
  end

  # this method will redirect the user to the main page if the filter does not pass
  def correct_user
    @user = User.find(params[:id])

    if @user != current_user
     redirect_to(root_path)
    else
      # nothing to do
    end
  end

  def only_members
    @requirement = Requirement.find(params[:id])
    @team = @requirement.team

    if current_user == nil
      flash.now[:danger] = 'Este time está privado. Você precisa estar logado.'
      redirect_to signin_path
    elsif current_user != @team.user && current_user.member_of?(@team)
        flash[:danger] = 'Você precisa ser um membro deste time.'
        redirect_to teams_path
    else
      #nothing to do
    end
  end

end
