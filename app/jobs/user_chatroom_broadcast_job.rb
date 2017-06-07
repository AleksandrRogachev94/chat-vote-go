class UserChatroomBroadcastJob < ApplicationJob
  queue_as :users

  def perform(user_chatroom)
    result = ActiveModelSerializers::SerializableResource.new(user_chatroom).as_json
    result[:type] = 'create'
    ActionCable.server.broadcast "chatroom_#{user_chatroom.chatroom_id}:users", result
  end
end
