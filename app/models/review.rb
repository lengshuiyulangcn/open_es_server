class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewer, class_name: "User", foreign_key: 'user_id'
  belongs_to :section

end
