# File: portal_controller_spec.rb
# Purpose: Receive the tests of sessions controller
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.
require 'rails_helper'

include SessionsHelper

RSpec.describe SessionsHelper, :type => :helper do
  # instantiate a user with the mandatory params
  before do
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123',
                                    password_confirmation: 'sanjana123')
    @user.save
  end

  # test to compare if the user signed in is the current user
  describe '#current_user?' do
    context 'compared with @user' do
      it 'must return true' do
        sign_in @user
        expect(current_user).to eq(@user)
      end
    end
  end

  # test to verify if the user can sign out with succes
  describe '#sign_out' do
      it 'the user should logout with success' do
        sign_in @user
        sign_out
        expect(current_user).to be(nil)
    end
  end 

  # test to verify if the current user is null, after the user signed out
  describe '#signed_in?' do
    it 'expect signout to clear current_user' do
      sign_in @user
      sign_out
      expect(signed_in?).to be(false)
    end
  end

  describe '#current_user?' do
    context 'comparison between the same user' do
      it 'should return true' do
        sign_in @user
        expect(current_user?(@user)).to eq true
      end
    end
  end
end
