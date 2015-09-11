# File: invite.rb.
# Purpose: The invite model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
end