class SuggestionBroadcastJob < ApplicationJob
  queue_as :suggestions

  def perform(suggestion)
    result = ActiveModelSerializers::SerializableResource.new(suggestion).as_json
    result[:type] = 'create'
    ActionCable.server.broadcast "chatroom_#{suggestion.chatroom_id}:suggestions", result
  end
end
