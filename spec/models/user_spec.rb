# encoding: utf-8
require 'spec_helper'

describe User do

  it "should require an email" do
    user = FactoryGirl.build(:user, email: nil)
    user.should_not be_valid
    user.errors_on(:email).should == ["can't be blank"]
  end

  it "should require an uuid" do
    user = FactoryGirl.build(:user, uuid: nil)
    user.should_not be_valid
    user.errors_on(:uuid).should == ["can't be blank"]
  end

  it "should require an unique uuid" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user, uuid: user1.uuid)
    user2.should_not be_valid
    user2.errors_on(:uuid).should == ["has already been taken"]
  end

  describe ".find_or_create_from_passaporte_web" do
    let(:auth_hash) { {"provider"=>"passaporte_web", "uid"=>"some-unique-uuid-42", "info"=>{"uuid"=>"some-unique-uuid-42", "nickname"=>nil, "email"=>"user42@example.com", "first_name"=>"contabil", "last_name"=>"contabil", "name"=>"contabil contabil"}, "credentials"=>{"token"=>"G6zJuSeCOJVTCbGN", "secret"=>"lpWxlDrWSZpogfSU"}, "extra"=>{"access_token"=>'some access token', "user_hash"=>{"last_name"=>"contabil", "is_active"=>false, "notifications"=>{"count"=>0, "list"=>"/notifications/api/"}, "accounts"=>[], "services"=>{"contabil"=>"/accounts/api/service-info/some-unique-uuid-42/contabil/"}, "timezone"=>nil, "nickname"=>nil, "first_name"=>"contabil", "send_partner_news"=>false, "uuid"=>"some-unique-uuid-42", "language"=>nil, "country"=>nil, "update_info_url"=>"/profile/api/info/some-unique-uuid-42/", "send_myfreecomm_news"=>false, "gender"=>nil, "birth_date"=>nil, "email"=>"user42@example.com"}}} }
    context "when the user already exists" do
      let!(:user) { FactoryGirl.create(:user, email: 'user42@example.com', uuid: 'some-unique-uuid-42') }
      it "should return the correct user" do
        described_class.find_or_create_from_passaporte_web(auth_hash).should == user
      end
    end
    context "when the user does not exist" do
      it "should create an user and return it" do
        expect { described_class.find_or_create_from_passaporte_web(auth_hash) }.to change(User, :count).by(1)
      end
      it "should set the correct attributes on the new user" do
        user = described_class.find_or_create_from_passaporte_web(auth_hash)
        user.email.should == 'user42@example.com'
        user.uuid.should == 'some-unique-uuid-42'
      end
    end
  end

end
