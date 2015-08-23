require 'rails_helper'

include SessionsHelper

RSpec.describe SessionsController, :type => :controller do

  before do 
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123', 
                    password_confirmation: 'sanjana123')
    @user.save
  end

  describe   "POST" do
    describe '#create' do
      context "with right params" do
        subject { post :create, :session => { :email => 'sanjana@gmail.com', :password => 'sanjana123' }}
        it "should log in user with correct email and password" do
          subject
          expect(response).to redirect_to(root_path)
        end
      end
      context "with incorrect params" do
        subject { post :create, :session => { :email => '123eee', :password => 'sanjana123' }}
        it "should not change user_id" do
          subject
          expect(session[:user_id]).to be(nil)
        end
      end
    end
  end

  describe "#destroy" do
    it "should sign out the user" do
      sign_in(@user)
      get :destroy
      expect(session[:user_id]).to be(nil)
      expect(response).to redirect_to(root_path)
    end
  end
end
