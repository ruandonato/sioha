# File: team_spec.rb
# Purpose: Receive the unitary tests of model teams
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

require 'rails_helper'

RSpec.describe Team, :type => :model do

  # instantiate a user with the mandatory params
  before do
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123')
    @user.save

    # instantiate a team with the mandatory params
    @team = Team.new(name: "SiohaTecproggers", description: "The agile resistence!", user: @user,
                    methodology: "SAFe", public_to_members: true, email: "siohatecprog@gmai.com")
    @team.save
  end

  it {
      # insert new attributes here
      expect(@team).to respond_to(:name, :email, :description, :user, :methodology, :public_to_members,
                                  :email, :pending_invites)
     }
  it { expect(@user).to be_valid }

  # check if a team have pending invites
  describe '#pending_invites' do
    context 'with no pending invites' do
      it 'should return nothing' do
        a = []
        expect(@team.pending_invites).to eq a
      end
    end
  end

  # tests if a team is single
  describe "unique team" do
    it "should be_valid" do
      uniqueness_team = Team.new
        uniqueness_team.id = "1"
        uniqueness_team.name = "SiohaTec"
        uniqueness_team.user_id = "1"
        uniqueness_team.description = "The agile resistence!"
        uniqueness_team.methodology = "SAFe"
        uniqueness_team.public_to_members = true
        uniqueness_team.email = "ssiohatecprog@gmai.com"
        expect(uniqueness_team).to be_valid
      end
    end

  # tests if there is duplicate teams
  describe "duplicated process_number" do
      it "should not be_valid" do
        duplicated_team = Team.new
        duplicated_team.name= "SiohaTecproggers"
        duplicated_team.description = "The agile resistence!"
        expect(duplicated_team).not_to be_valid
    end
  end

  # test if one user story returns a feature
  describe '#upstream_traceability_scope' do
    context 'for user_story' do
      subject { @team.upstream_traceability_scope("UserStory") }
      it 'should return the team features' do
        expect(subject).to eq(@team.requirements.features)
      end
    end

    # test if the feature is returning a team investiment theme
    context 'for features' do
      subject { @team.upstream_traceability_scope("Feature") }
      it 'should return the team investiment themes' do
        expect(subject).to eq(@team.requirements.investiment_themes)
      end
    end
  end

  describe 'downstream_traceability_scope' do
    context 'for user_story' do
      subject { @team.downstream_traceability_scope("UserStory") }
      # do nothing
    end

    # test if one feature is returning team stories
    context 'for features' do
      subject { @team.downstream_traceability_scope("Feature") }
      it 'should return the team stories' do
        expect(subject).to eq(@team.requirements.stories)
      end
    end

    # test if investiment themes is returning features
    context 'for investiment themes' do
      subject { @team.downstream_traceability_scope("InvestimentTheme") }
      it 'should return the team features' do
        expect(subject).to eq(@team.requirements.features)
      end
    end
  end

end
