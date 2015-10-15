# File: invites_controller.rb.
# Purpose: Map actions relative to invite model
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class InvitesController < ApplicationController

  before_action :require_login

  # action that renders the index page of the invites controller
  def index
    @all_invites = Invite.where(user: current_user)
    @accepted_invites = @all_invites.where(accepted: true)
    @pending_invites = @all_invites.where(pending: true)
    @invites = @pending_invites
  end

end
