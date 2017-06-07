class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :section_tags, dependent: :destroy
  has_many :sections, class_name: "Section", through: :section_tags
end
