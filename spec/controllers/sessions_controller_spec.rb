# encoding: utf-8
require 'spec_helper'

describe SessionsController do

  # GET /auth/:provider/callback
  describe "create" do
    let(:params) { {provider: 'passaporte_web', oauth_verifier: "50201801", oauth_token: "KH6DOPpx98Motgg9"} }
    let(:oauth_data) { {"provider"=>"passaporte_web", "uid"=>"some-unique-uuid-42", "info"=>{"uuid"=>"some-unique-uuid-42", "nickname"=>nil, "email"=>"user42@example.com", "first_name"=>"contabil", "last_name"=>"contabil", "name"=>"contabil contabil"}, "credentials"=>{"token"=>"G6zJuSeCOJVTCbGN", "secret"=>"lpWxlDrWSZpogfSU"}, "extra"=>{"access_token"=>'some access token', "user_hash"=>{"last_name"=>"contabil", "is_active"=>false, "notifications"=>{"count"=>0, "list"=>"/notifications/api/"}, "accounts"=>[], "services"=>{"contabil"=>"/accounts/api/service-info/some-unique-uuid-42/contabil/"}, "timezone"=>nil, "nickname"=>nil, "first_name"=>"contabil", "send_partner_news"=>false, "uuid"=>"some-unique-uuid-42", "language"=>nil, "country"=>nil, "update_info_url"=>"/profile/api/info/some-unique-uuid-42/", "send_myfreecomm_news"=>false, "gender"=>nil, "birth_date"=>nil, "email"=>"user42@example.com"}}} }
    let!(:user) { FactoryGirl.create(:user, email: 'user42@example.com', uuid: 'some-unique-uuid-42') }
    before(:each) do
      request.env["omniauth.auth"] = oauth_data
    end
    it "should find the user" do
      get :create, params
      assigns(:user).should == user
    end
    it "should log in the user" do
      session[:user_id].should be_nil
      get :create, params
      session[:user_id].should == user.id
    end
    it "should redirect to the root path with a success message" do
      get :create, params
      response.should redirect_to(root_path)
      flash[:notice].should == "Hello #{user.email}!"
    end
  end

  # GET /logout
  describe "destroy" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) { session[:user_id] = user.id }
    it "should log out the user" do
      get :destroy
      session[:user_id].should be_nil
    end
    it "should redirect to the root path with a status message" do
      get :destroy
      response.should redirect_to(root_path)
      flash[:notice].should == "Not logged in anymore."
    end
  end

end
