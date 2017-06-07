class SuggestionRemoveBroadcastJob < ApplicationJob
  queue_as :suggestions

  def perform(result)
    result[:type] = 'destroy'
    ActionCable.server.broadcast "chatroom_#{result[:suggestion][:chatroom_id]}:suggestions", result
  end
end
