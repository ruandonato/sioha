# File: team_spec.rb
# Purpose: Receive the tests of users controller
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

RSpec.describe UsersController, type: :controller do
  include SessionsHelper

  before do
    # instantiate a user with the mandatory params
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123', name: 'oldname')
    @user.save

    # instantiate a another user with the mandatory params
    @another_user = User.new(email: 'sanjana222@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123')
    @another_user.save

    # instantiate other user with the mandatory params
    @other_user = { email: 'sanjana2@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123' }
  end

  # checks if a controller_user calls a view new to creat a new user 
  describe "GET" do
    describe '#new' do
      it "should have http_status success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    # checks if a controller_user calls a view edit to edit a new user 
    describe '#edit' do
      context 'logged and with the correct user' do
        it "should return success" do
          sign_in @user
          get :edit, id: @user.id
          expect(response).to have_http_status(:success)
        end
      end

      # redirect a user to initial page if he is not logged in system
      context 'not logged' do
        it "should redirect" do
          get :edit, id: @user.id
          expect(response).to have_http_status(:redirect)
        end
      end

      # redirect a user to initial page if his login is incorrect
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

    # checks users logged, and redirect to show_user
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
    # check if a user is created with valid params
    describe '#create' do
      context 'with valid params' do
        subject { post :create, :user => @other_user }
        it "should create user show page" do
          subject
          new_user = User.find_by(:email => 'sanjana2@gmail.com')
          expect(get :show, :id => new_user.id).to have_http_status(:success)
        end

        # if a user is valid, increments a user in total number of users
        it "should increase total number of users" do
          expect { subject }.to change(User, :count).by(1)
        end
      end
      # check if a user is created with invalid params
      context 'with invalid params' do
        it "should not create user with invalid params" do
          post :create, :user => { :email => @user.email, :password => 'anewuserpassword', :password_confirmation => 'anewuserpassword' }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  # testing if the user can change his name
  describe "PUT" do
    describe '#update' do
      context 'with valid params' do
        before do
          sign_in @user
        end
        subject { put :update, id: @user.id, user: { name: 'anewname', password: 'sanjana123', password_confirmation: 'sanjana123',
                                                     email: 'sanjana@gmail.com'} }
        it "should change the current user name" do
          subject
          @user.reload
          expect(@user.name).to eq("anewname")
        end
      end

      # checking if the user is logged in
      context 'with invalid params' do
        before do
          sign_in @user
        end
        # testing if the user can not change his name with incorrect params
        subject { put :update, id: @user.id, user: { name: 'an', password: 'sanjana123', password_confirmation: 'sanjana123',
                                                     email: 'sanaaa' } }
        it "should not change the current user name" do
          subject
          @user.reload
          expect(@user.email).to eq("sanjana@gmail.com")
        end
      end
    end
  end
end
