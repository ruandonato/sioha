# File: team_spec.rb
# Purpose: Receive the unitary tests of model teams
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user: @user)
  end

  describe '#member_of?' do
    context 'with a given user being a member' do
      subject { @team.members.push @user }
      it 'should return true' do
        subject
        expect(@user.member_of?(@team)).to eq(true)
      end
    end
  end

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
    context 'with no invite pending' do
      it 'should return nil' do
        expect(@user.pending_to?(@team)).to eq(nil)
      end
    end
  end
end
