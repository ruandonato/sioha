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

  describe "unique team" do
    it "should be_valid" do
      uniqueness_team = Team.new
        uniqueness_team.id = "1"
        uniqueness_team.name = "SiohaTec"
        uniqueness_team.user_id = "1"
        uniqueness_team.description = "The agile resistence!"
        uniqueness_team.methodology = "SAFe"
        uniqueness_team.public_to_members = true
        uniqueness_team.email = "ssiohatecprog@gmai.com"
        expect(uniqueness_team).to be_valid
      end
    end

    describe "duplicated process_number" do
      it "should not be_valid" do
        duplicated_team = Team.new
        duplicated_team.name= "SiohaTecproggers"
        duplicated_team.description = "The agile resistence!"
        expect(duplicated_team).not_to be_valid
    end
  end
end
