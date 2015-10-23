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

  describe   "GET" do
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

  describe   "GET" do
      describe '#index' do
        it 'should return sucess' do
          sign_in @user
          get :index
          expect(response).to have_http_status(:success)
          end
        end
      end

    describe   "GET" do
      describe '#myteams' do
        it 'should return sucess' do
          sign_in @user
          get :myteams
          expect(response).to have_http_status(:success)
          end
        end
      end

  end