# File: team_spec.rb
# Purpose: Receive the unitary tests of model teams
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

require 'rails_helper'

#instantiate a user and team 

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user: @user)
  end

  # check if a user is a member of team
  describe '#member_of?' do
    context 'with a given user being a member' do
      subject { @team.members.push @user }
      it 'should return true' do
        subject
        expect(@user.member_of?(@team)).to eq(true)
      end
    end
  end

  # check if a team have a pending invite for users
  describe '#pending_to?' do
    context 'with an invite pending' do
      before do
        @invite = Invite.new(user: @user, team: @team)
        @invite.save
        @invite.reload
      end

      it 'should return true' do
        expect(@user.pending_to?(@team)).to eq(true)
      end
    end

    # check if a team have no pending invite for users
    context 'with no invite pending' do
      it 'should return nil' do
        expect(@user.pending_to?(@team)).to eq(nil)
      end
    end
  end
end
