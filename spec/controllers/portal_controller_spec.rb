require 'rails_helper'

RSpec.describe PortalController, :type => :controller do
describe "GET" do 
    describe '#index' do
      it "should work" do 
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end