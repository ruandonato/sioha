# File: requirements_controller.rb.
# Purpose: Map actions relative to requirement model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class RequirementsController < ApplicationController
  # checks if the user is logged in sistem
  before_action :require_login, only: [:new, :create, :edit, :update]
  # checks if a user is member of a team
  before_action :only_members, only: [:edit, :update]

  # this action renders the page of information about the requirements
  def show
    @requirement = Requirement.find(params[:id])
    @team = @requirement.team
  end

  # action renders the page of a new requirements
  def new
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @requirement = Requirement.new(team: @team, author: @user)
  end

  # action that renders a page of edit requiriments 
  def edit
    @requirement = Requirement.find(params[:id])
    @team = @requirement.team
  end

  # this method update edited requirements
  def update
    @requirement = Requirement.find(params[:id])
    @team = @requirement.team

    if @requirement.type == "UserStory"
      @requirement.update_attributes(user_story_params)
    elsif @requirement.type == "Feature"
      @requirement.update_attributes(feature_params)
    elsif @requirement.type == "InvestimentTheme"
      @requirement.update_attributes(investiment_theme_params)
    else
      render 'edit'
    end

    if @requirement.save
      flash[:success] = 'Informações alteradas!'
      redirect_to '/requirements/' + @requirement.id.to_s
    else
      render 'edit'
    end
  end

  # action creates a new requirement 
  def create
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])

    @requirement = Requirement.new(requirement_params)
    @requirement.team = @team
    @requirement.author = @user

    if @requirement.save
      redirect_to @team
    else
      render 'new'
    end
  end

  private

  # checks mandatory params for create a requirement
  def requirement_params
    params.require(:requirement).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end

  # checks mandatory params for creat a user story
  def user_story_params
    params.require(:user_story).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end
  # checks mandatory params for creat a feature
  def feature_params
    params.require(:feature).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end
  # checks mandatory params for creat a investiment theme
  def investiment_theme_params
    params.require(:investiment_theme).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end

end
