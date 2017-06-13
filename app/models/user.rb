class User < ApplicationRecord
  enum role: {admin: 0, teacher: 1, student: 2}
  has_many :created_sections, class_name: "Section", foreign_key: 'user_id', inverse_of: :author, dependent: :destroy
  has_many :assigned_sections, class_name: "Section", foreign_key: 'assignee_id', inverse_of: :assignee, dependent: :destroy
  has_many :modifications, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :modified_sections, through: :modifications, source: :section, dependent: :destroy
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    login = auth[:info][:login]
    email = auth[:info][:email]
    if(auth[:info][:avatar_url][0..3]!= 'http')
      avatar_url = "https://forum.qilian.jp" + auth[:info][:avatar_url]
    else
      avatar_url = auth[:info][:avatar_url]
    end

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.avatar_url = avatar_url
      user.email = email
      user.login = login
    end
  end
end
