class Review < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :reviewer, class_name: "User", foreign_key: 'user_id', dependent: :destroy
  belongs_to :section

end
