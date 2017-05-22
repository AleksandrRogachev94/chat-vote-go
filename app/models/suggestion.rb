class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  has_reputation :votes, source: :user, aggregated_by: :sum

  validates :title, presence: true
end
