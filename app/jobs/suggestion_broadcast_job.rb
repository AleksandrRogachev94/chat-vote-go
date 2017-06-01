class SuggestionBroadcastJob < ApplicationJob
  queue_as :suggestions

  def perform(suggestion)
    ActionCable.server.broadcast "chatroom_#{suggestion.chatroom_id}:suggestions",
      suggestion: SuggestionSerializer.new(suggestion).as_json
  end
end
