require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RequirementsHelper. For example:
#
# describe RequirementsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do

  before do
    @user = FactoryGirl.create(:user)
  end

  describe '#gravatar_for' do
    it 'should return an image_tag for a given user' do
      gravatar_temp_id = Digest::MD5::hexdigest(@user.email.downcase)
      gravatar_temp_url = "https://secure.gravatar.com/avatar/#{gravatar_temp_id}"
      expect(gravatar_for(@user)).to eq(image_tag(gravatar_temp_url, alt: @user.name, class: 'gravatar' ))
    end
  end

end
