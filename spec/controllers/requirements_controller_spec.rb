require 'rails_helper'

RSpec.describe RequirementsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user: @user)
    @requirement = FactoryGirl.create(:requirement, team: @team, author: @user)
  end

  describe "GET" do
    describe '#show' do
      context 'with valid params' do
        it 'should have http status success' do
          get :show, id: @requirement.id
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe '#new' do
      it 'should return success' do
        sign_in @user
        get :new, team_id: @team.id, user_id: @user.id
        expect(response).to have_http_status(:success)
      end
    end

    describe '#edit' do
      it 'should return success' do
        sign_in @user
        get :edit, id: @requirement.id
        expect(response).to have_http_status(:success)
      end
    end
  end
end
