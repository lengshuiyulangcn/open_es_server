class Section < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_one :modification
  validates :title, presence: true, length: {maximum: 30}
  validates :content, presence: true
  paginates_per 10
end
