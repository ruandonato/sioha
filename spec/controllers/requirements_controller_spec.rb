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

  describe "POST" do
    describe '#create' do
      context 'with valid params' do
        before do
          sign_in @user
        end

        it "should increase total number of requirements of a given team" do
          total = @team.requirements.count
          post :create, team_id: @team.id, user_id: @user.id, requirement: { code: "US002002", description: "NICE STORY BRO", type: "UserStory", priority: "high" }
          @team.requirements.reload
          expect(@team.requirements.count).to eq(total+1)
        end
      end

      context 'with invalid params' do
        before do
          sign_in @user
        end

        it "should not increase total number of requirements of a given team" do
          total = @team.requirements.count
          post :create, team_id: @team.id, user_id: @user.id, requirement: { code: "U", description: "NICE STORY BRO", type: "UserStory", priority: "high" }
          @team.requirements.reload
          expect(@team.requirements.count).to eq(total) # total number of requirements will not change
        end
      end
    end
  end
end
