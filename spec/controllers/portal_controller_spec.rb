# File: portal_controller_spec.rb
# Purpose: Receive the  tests of portal controller
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

require 'rails_helper'

RSpec.describe PortalController, :type => :controller do
  # instantiate a user with the mandatory params
  before do
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123')
    @user.save
  end

  # redirect user logged to initial page of users
  describe "GET" do
    describe '#index' do
      context 'with logged user' do
        it "should work" do
          sign_in @user
          get :index
          expect(response).to have_http_status(:success)
        end
      end

      # redirect user is unlogged to initial page of application
      context 'with unlogged user' do
        it "should work" do
          get :index
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
