class RequirementsController < ApplicationController

  def show
    @requirement = Requirement.find(params[:id])
  end

  def new
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @requirement = Requirement.new(team: @team, author: @user)
  end

  def edit
    @requirement = Requirement.find(params[:id])
  end

  def update
    @requirement = Requirement.find(params[:id])
    if @requirement.kind_of? UserStory
      @requirement.update_attributes(user_story_params)
      flash[:success] = 'Informações alteradas!'
      redirect_to '/requirements/' + @requirement.id.to_s
    elsif @requirement.kind_of? Feature
      @requirement.update_attributes(feature_params)
      flash[:success] = 'Informações alteradas!'
      redirect_to '/requirements/' + @requirement.id.to_s
    elsif @requirement.kind_of? InvestimentTheme
      @requirement.update_attributes(investiment_theme_params)
      flash[:success] = 'Informações alteradas!'
      redirect_to '/requirements/' + @requirement.id.to_s
    else
      render 'edit'
    end
  end

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

  def requirement_params 
    params.require(:requirement).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end

  def user_story_params 
    params.require(:user_story).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end

  def feature_params 
    params.require(:feature).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end

  def investiment_theme_params 
    params.require(:investiment_theme).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end

end
