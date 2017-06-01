class MessageBroadcastJob < ApplicationJob
  queue_as :messages

  def perform(message)
    ActionCable.server.broadcast "chatroom_#{message.chatroom_id}:messages",
      ActiveModelSerializers::SerializableResource.new(message).as_json
  end
end
