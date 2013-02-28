require 'spec_helper'

describe PagesController do

  describe "GET 'public'" do
    it "returns http success" do
      get 'public'
      response.should be_success
    end
  end

  describe "GET 'private'" do
    let(:user) { FactoryGirl.create(:user) }
    it "returns http success when logged in" do
      session[:user_id] = user.id
      get 'private'
      response.should be_success
    end
    it "redirects to public when NOT logged in" do
      session[:user_id] = nil
      get 'private'
      response.should redirect_to(root_url)
      flash[:alert].should == 'You must be logged in to access this resource.'
    end
  end

end
