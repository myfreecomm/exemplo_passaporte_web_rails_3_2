# encoding: utf-8
class User < ActiveRecord::Base

  validates_presence_of :email, :uuid
  validates_uniqueness_of :uuid, allow_blank: true

  def self.find_or_create_from_passaporte_web(auth_hash)
    user = self.find_by_uuid(auth_hash['uid'])
    return user unless user.nil?
    self.create! do |user|
      user.uuid = auth_hash["uid"]
      user.email = auth_hash["info"]["email"]
    end
  end

end
