# File: teams_controller.rb.
# Purpose: Map actions relative to team model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class TeamsController < ApplicationController

  before_action :require_login, only: [:new, :create, :index]
  before_action :only_members, only: [:invite, :show_private_team]

  # action that renders the new page of the teams controller
  def new
    @team = Team.new
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
    @teams += Team.where(user: current_user)
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
      only_members
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

  private

  # this method passing parameters to the edit page and creating team
  def team_params
    params.require(:team).permit(:name, :description, :user_id, :email, :picture,
                                 :public_to_members, :methodology)
  end

  # this method prohibits non-members to see a private team
  def only_members
    @team = Team.find(params[:id])
    if current_user == nil
      flash.now[:danger] = 'Este time está privado. Você precisa estar logado.'
      redirect_to signin_path
    else
      unless current_user == @team.user || current_user.member_of?(@team)
        flash[:danger] = 'Você precisa ser um membro deste time.'
        redirect_to teams_path
      end
    end
  end

end