# File: teams_controller_spec.rb
# Purpose: Receive the tests of controller teams
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

require 'rails_helper'


RSpec.describe TeamsController, type: :controller do

before do
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123')
    @user.save

    @team = Team.new(name: "SiohaTecproggers", description: "The agile resistence!", user: @user,
                    methodology: "SAFe", public_to_members: true, email: "siohatecprog@gmai.com")
    @team.save

  end

  describe "GET" do
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

    describe '#index' do
      it 'should return sucess' do
        sign_in @user
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe '#myteams' do
      it 'should return sucess' do
        sign_in @user
        get :myteams
        expect(response).to have_http_status(:success)
      end
    end

    describe '#edit' do
      context 'with logged user' do
        subject { get :edit, id: @team.id }
        it "should return success" do
          subject
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe '#show' do
      context 'with valid team' do
        subject { get :show, id: @team.id }
        it "should return success" do
          subject
          expect(response).to have_http_status(:success)
        end
      end
    end

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

    describe "POST" do
      describe '#create' do
        context 'with valid params' do
          before do
            sign_in @user
          end
          subject { post :create, team: { name: "SIOHATECPROGGERSzz", description: "balblaleaeabalbalbla", user: @user } }
          it "should create a new user" do
            total = Team.all.count
            subject
            Team.all.reload
            new_total = Team.all.count
            expect(new_total).to eq(total+1)
          end
        end
      end
    end

    describe '#accept_invite' do
      before do
        @invite = Invite.new(user: @user, team: @team)
        @invite.save
      end

      it 'should change invite do accepted' do
        get :accept_invite, invite_id: @invite.id, id: @user.id
        @invite.reload
        expect(@invite.accepted).to eq(true)
        expect(@invite.pending).to eq(false)
      end
    end

    describe '#refuse_invite' do
      before do
        @invite = Invite.new(user: @user, team: @team)
        @invite.save
      end

      it 'should change invite do accepted' do
        get :refuse_invite, invite_id: @invite.id, id: @user.id
        @invite.reload
        expect(@invite.accepted).to eq(false)
        expect(@invite.pending).to eq(false)
      end
    end

  end
