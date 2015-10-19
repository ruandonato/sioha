require 'rails_helper'

RSpec.describe Team, :type => :model do

  before do
    @user = User.new(email: 'sanjana@gmail.com', password: 'sanjana123',
                    password_confirmation: 'sanjana123')
    @user.save

    @team = Team.new(name: "SiohaTecproggers", description: "The agile resistence!", user: @user,
                    methodology: "SAFe", public_to_members: true, email: "siohatecprog@gmai.com")
    @team.save
  end

  it {
      #insert new attributes here
      expect(@team).to respond_to(:name, :email, :description, :user, :methodology, :public_to_members,
                                  :email, :pending_invites)
     }
  it { expect(@user).to be_valid }

  describe '#pending_invites' do
    context 'with no pending invites' do
      it 'should return nothing' do
        a = []
        expect(@team.pending_invites).to eq a
      end
    end
  end

end
