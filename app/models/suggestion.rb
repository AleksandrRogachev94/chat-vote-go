class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :title, presence: true
end
