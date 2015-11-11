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

  describe "PUT" do
    describe '#update' do
      before do
        sign_in @user
      end

      context 'for an user story' do
        it "should update attributes of a given requirement" do
          expect(@requirement.code).to eq("US00002")
          put :update, :user_story => { :code => "UXXX2222", :type => "UserStory" }, id: @requirement.id
          @requirement.reload
          expect(@requirement.code).to eq("UXXX2222")
        end
      end

      context 'for a feature' do
        before do
          sign_in @user
          @feature = FactoryGirl.create(:requirement, team: @team, author: @user, type: "Feature", code: "FT00002")
        end

        it "should update attributes of a given requirement" do
          expect(@feature.code).to eq("FT00002")
          put :update, :feature => { :code => "UXXX2222", :type => "Feature" }, id: @feature.id
          @feature.reload
          expect(@feature.code).to eq("UXXX2222")
        end
      end

      context 'for an investiment theme' do
        before do
          sign_in @user
          @investiment_theme = FactoryGirl.create(:requirement, team: @team, author: @user, type: "InvestimentTheme", code: "IT00002")
        end

        it "should update attributes of a given requirement" do
          expect(@investiment_theme.code).to eq("IT00002")
          put :update, :investiment_theme => { :code => "UXXX2222", :type => "Feature" }, id: @investiment_theme.id
          @investiment_theme.reload
          expect(@investiment_theme.code).to eq("UXXX2222")
        end
      end

      context 'with invalid requirement type' do
        before do
          sign_in @user
          @random_requirement = FactoryGirl.create(:requirement, team: @team, author: @user, type: "UserStory", code: "XZ00002")
        end

        it 'should redirect' do
          put :update, :user_story => { :code => "UXXX2222", :type => "Requirement" }, id: @random_requirement
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end
end
