# File: portal_controller.rb.
# Purpose: Contains initial Sioha pages
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class PortalController < ApplicationController

  
	# action that renders the index page of the portal controller
  def index
    if signed_in?
      @invites = Invite.where(user: current_user, pending: true)
      @invites += Invite.where(user: current_user, pending: nil)
    else
      # nothing to do
    end
    
    @teams = Team.where(public_to_members: true)
    @teams = @teams.last(5)
    @users = User.last(5)
  end

end