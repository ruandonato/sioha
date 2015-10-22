# File: teams_controller_spec.rb
# Purpose: Receive the tests of controller teams
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

require 'rails_helper'


RSpec.describe TeamsController, type: :controller do

before do
 @team = Team.new(name: "SiohaTecproggers", description: "The agile resistence!", user: @user,
                    methodology: "SAFe", public_to_members: true, email: "siohatecprog@gmai.com")
 
  @team.save
  end

describe "GET" do
  describe '#new' do
    it "should work" do
      get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

end