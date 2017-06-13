class Section < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id", inverse_of: :created_sections
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true, inverse_of: :assigned_sections
  has_one :modification, dependent: :delete
  has_many :section_tags, dependent: :destroy
  has_many :tags, class_name: "Tag", through: :section_tags
  has_many :reviews, dependent: :destroy
  has_many :reviewers, class_name: "User", through: :reviews, dependent: :destroy
  validates :title, presence: true, length: {maximum: 30}
  validates :content, presence: true
  paginates_per 10


  def message_recevers_ids
    reviewers.uniq.pluck(:id)
  end
end
