# File: team_spec.rb
# Purpose: Receive the tests of users controller
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

RSpec.describe UsersController, type: :controller do
  include SessionsHelper

  before do
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123')
    @user.save

    @another_user = User.new(email: 'sanjana222@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123')
    @another_user.save

    @other_user = { email: 'sanjana2@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123' }
  end

  describe "GET" do
    describe '#new' do
      it "should have http_status success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe '#edit' do
      context 'logged and with the correct user' do
        it "should return success" do
          sign_in @user
          get :edit, id: @user.id
          expect(response).to have_http_status(:success)
        end
      end

      context 'not logged' do
        it "should redirect" do
          get :edit, id: @user.id
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'with the wrong user' do
        context 'not logged' do
          it "should redirect" do
            sign_in @another_user
            get :edit, id: @user.id
            expect(response).to have_http_status(:redirect)
          end
        end
      end

    end

    describe '#show' do
      context 'signed user' do
        it "should have http_status success" do
          sign_in @user
          get :show, :id => @user.id
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe "POST" do
    describe '#create' do
      context 'with valid params' do
        subject { post :create, :user => @other_user }
        it "should create user show page" do
          subject
          new_user = User.find_by(:email => 'sanjana2@gmail.com')
          expect(get :show, :id => new_user.id).to have_http_status(:success)
        end

        it "should increase total number of users" do
          expect { subject }.to change(User, :count).by(1)
        end
      end

      context 'with invalid params' do
        it "should not create user with invalid params" do
          post :create, :user => { :email => @user.email, :password => 'anewuserpassword', :password_confirmation => 'anewuserpassword' }
          expect(response).to render_template(:new)
        end
      end

    end
  end
end
