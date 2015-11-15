  # File: teams_controller.rb.
# Purpose: Map actions relative to team model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class TeamsController < ApplicationController
  # these two methods gives access to controll teams only for users
  before_action :require_login, only: [:new, :create, :index, :invite]
  before_action :only_members, only: [:invite, :show_private_team]
  before_action :unique_invite, only: [:invite_member]

  # action that renders the new page of the teams controller
  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(team_params)
      flash[:success] = 'Informações alteradas!'
      redirect_to @team
    else
      render 'edit'
    end
  end

  # this method creates a new team
  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if(@team.save)
      redirect_to @team
    else
      render 'new'
    end
  end

  # action that renders the myteams page
  def myteams
    @teams = []
    team_members = TeamMember.where(user: current_user)
    team_members.each do |t|
      @teams.push t.team
    end
    @teams += current_user.teams
  end

  # action that shows a team
  def show
    @team = Team.find(params[:id])
    accepted_invites = @team.invites.where(accepted: true)
    @members = @team.members

    if @team.public_to_members
      @invites = @team.pending_invites
    else
      @invites = @team.pending_invites
      if(current_user.member_of? @team)

      else
        flash[:danger] = "Você precisa ser um membro desse time."
        redirect_to root_path
      end
    end
  end

  # action that renders the index page of the teams controller
  def index
    @teams = Team.where(public_to_members: true)
    @teams = @teams.paginate(page: params[:page], per_page: 10)
  end

  # action that renders the page to invite users to a team
  def invite
    @team = Team.find(params[:id])
    @users = User.search(params[:keyword], params[:filter])
  end

  # this method sends the team's invitation to a member
  def invite_member
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    @invite = Invite.new(user: @user, team: @team, pending: true, accepted: nil)
    @invite.save
    redirect_to @team
  end

  # this method accepts an invitation sent
  def accept_invite
    @user = User.find(params[:id])
    @invite = Invite.find(params[:invite_id])
    @invite.pending = false
    @invite.accepted = true
    @invite.save
    @invite.team.members.push @user
    @invite.team.save
    redirect_to @invite.team
  end

  # this method declines an invitation sent
  def refuse_invite
    @user = User.find(params[:id])
    @invite = Invite.find(params[:invite_id])
    @invite.pending = false
    @invite.accepted = false
    @invite.save
    redirect_to @invite.team
  end

  def team_requirements
    @team = Team.find(params[:id])
    @requirements = @team.requirements
    respond_to do |format|
      format.js
      format.html
    end
  end

  def wiki
    @team = Team.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit_wiki
    @team = Team.find(params[:id])
  end

  # this method passing parameters to the edit page and creating team
  private

  def unique_invite
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    invite = Invite.find_by(user: @user, team: @team)
    if invite
      redirect_to @team
      flash[:danger] = 'Este usuário já tem um convite pendente para este time!'
    else
      # do nothing
    end
  end

  def team_params
    params.require(:team).permit(:name, :description, :user_id, :email, :picture,
                                 :public_to_members, :methodology, :wiki)
  end

end
