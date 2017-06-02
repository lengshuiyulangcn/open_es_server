class User < ApplicationRecord
  has_many :created_sections, class_name: "Section", foreign_key: 'user_id'
  has_many :modifications
  has_many :modified_sections, through: :modifications, source: :section
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    email = auth[:info][:email]
    avatar_url = "https://forum.qilian.jp" + auth[:info][:avatar_url]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.avatar_url = avatar_url
      user.email = email
    end
  end
end
