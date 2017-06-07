class SectionTag < ApplicationRecord
  belongs_to :section, dependent: :destroy
  belongs_to :tag, dependent: :destroy
end
