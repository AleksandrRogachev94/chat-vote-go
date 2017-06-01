class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  has_reputation :votes, source: :user, aggregated_by: :sum

  after_create_commit { SuggestionBroadcastJob.perform_later self }
  # after_update_commit { SuggestionBroadcastJob.perform_later self }

  validates :title, presence: true

  def add_evaluation_with_broadcasting(*args)
    self.add_evaluation(*args)
    SuggestionBroadcastJob.perform_later self
  end

  def delete_evaluation_with_broadcasting(*args)
    self.delete_evaluation(*args)
    SuggestionBroadcastJob.perform_later self
  end
end
