# File: teams_controller_spec.rb
# Purpose: Receive the tests of controller teams
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
# instantiate a user and a team with the mandatory params
before do
    @user = FactoryGirl.create(:user)

    @team = Team.new(name: "SiohaTecproggers", description: "The agile resistence!", user: @user,
                    methodology: "SAFe", public_to_members: true, email: "siohatecprog@gmai.com")
    @team.save

  end

# sign in a user
  describe "GET" do
    describe '#invite_member' do
      before do
        sign_in @user
      end

      # test for create a new invite, with the correct params
      it "should create a new invite" do
        total = Invite.all.count
        get :invite_member, id: @team.id, user_id: @user.id
        expect(Invite.all.count).to eq(total+1)
      end

      # test for one member has only one invete for each team
      it 'should have only one invite by team-member pair' do
        total = Invite.all.count
        get :invite_member, id: @team.id, user_id: @user.id
        expect(Invite.all.count).to eq(total+1)
        get :invite_member, id: @team.id, user_id: @user.id
        expect(Invite.all.count).to eq(total+1) # total not increased by last #invite_member call
      end
    end

    # testing if a user is signed in
    describe '#new' do
      context "logged user" do
        it 'should return sucess' do
          sign_in @user
          get :new
          expect(response).to have_http_status(:success)
          end
        end
      end
    end

    # testing if the page is returning to index when the user sign in
    describe '#index' do
      it 'should return sucess' do
        sign_in @user
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    # testing if the user can enter on his teams
    describe '#myteams' do
      it 'should return sucess' do
        sign_in @user
        get :myteams
        expect(response).to have_http_status(:success)
      end
    end

    # testing if the user can edit his team
    describe '#edit' do
      context 'with logged user' do
        subject { get :edit, id: @team.id }
        it "should return success" do
          subject
          expect(response).to have_http_status(:success)
        end
      end
    end

    # testing if the user can see his teams
    describe '#show' do
      context 'with valid team' do
        subject { get :show, id: @team.id }
        it "should return success" do
          subject
          expect(response).to have_http_status(:success)
        end
      end
    end

    # testing if the user can add a description into his team
    describe "PUT" do
      describe '#update' do
        context 'with valid params' do
          subject { put :update, id: @team.id, team: { description: "anewdescription" } }
          it "should change the description" do
            subject
            @team.reload
            expect(@team.description).to eq("anewdescription")
          end
        end

        # testing if the user try to enter a description with few characters 
        context 'with invalid params' do
          subject { put :update, id: @team.id, team: { description: "an" } }
          it "should not change the description" do
            subject
            @team.reload
            expect(@team.description).to eq("The agile resistence!")
          end
        end
      end
    end

    # cheking if the user is logged in
    describe "POST" do
      describe '#create' do
        context 'with valid params' do
          before do
            sign_in @user
          end

          # testing if the user can create a new team
          subject { post :create, team: { name: "SIOHATECPROGGERSzz", description: "balblaleaeabalbalbla", user: @user } }
          it "should create a new team" do
            total = Team.all.count
            subject
            Team.all.reload
            new_total = Team.all.count
            expect(new_total).to eq(total+1)
          end
        end

        # testing if the user can not create a team with invalid params
        context 'with unlogged user' do
          subject { post :create, team: { name: "SIOHATECPROGGERSzz", description: "balblaleaeabalbalbla", user: @user } }
          it "should not create a new team" do
            total = Team.all.count
            subject
            Team.all.reload
            new_total = Team.all.count
            expect(new_total).not_to eq(total+1)
          end
        end

        # checking if the user is logged in
        context 'with logged user' do
          describe 'with invalid params' do
            before do
              sign_in @user
            end

            # testing if the user can not create a team with invalid params
            subject { post :create, team: { name: "sioh", description: "a"*45, user: @user } }
            it "should not create a new team" do
              total = Team.all.count
              subject
              Team.all.reload
              new_total = Team.all.count
              expect(new_total).not_to eq(total+1)
            end
          end
        end
      end
    end

    # testing if the user can accept a team invite
    describe '#accept_invite' do
      before do
        @invite = Invite.new(user: @user, team: @team)
        @invite.save
      end

      # testing the invites if they are changing status for accepted
      it 'should change invite do accepted' do
        get :accept_invite, invite_id: @invite.id, id: @user.id
        @invite.reload
        expect(@invite.accepted).to eq(true)
        expect(@invite.pending).to eq(false)
      end
    end 

    # testing if the user can refuse an invite
    describe '#refuse_invite' do
      before do
        @invite = Invite.new(user: @user, team: @team)
        @invite.save
      end

      # testing the invites if they are changing the status for refuse
      it 'should change invite do accepted' do
        get :refuse_invite, invite_id: @invite.id, id: @user.id
        @invite.reload
        expect(@invite.accepted).to eq(false)
        expect(@invite.pending).to eq(false)
      end
    end

  end
