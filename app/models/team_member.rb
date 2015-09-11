# File: team_member.rb.
# Purpose: The team_member model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
end