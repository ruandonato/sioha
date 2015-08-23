require 'rails_helper'
  
include SessionsHelper

RSpec.describe SessionsHelper, :type => :helper do
  
  before do 
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123', 
                                    password_confirmation: 'sanjana123')
    @user.save
  end

  describe '#current_user?' do
    context 'compared with @user' do
      it 'must return true' do
        sign_in(@user)
        expect(current_user).to eq(@user)
      end
    end
  end

  describe '#sign_out' do
      it 'the user should logout with success' do
        sign_in(@user)
        sign_out
        expect(current_user).to be(nil)
    end
  end

  describe '#signed_in?' do
    it "expect signout to clear current_user" do
      sign_in(@user)
      sign_out
      expect(signed_in?).to be(false)
    end
  end
end
