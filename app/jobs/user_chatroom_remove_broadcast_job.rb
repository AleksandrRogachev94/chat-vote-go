class UserChatroomRemoveBroadcastJob < ApplicationJob
  queue_as :users

  def perform(result)
    result[:type] = 'destroy'
    ActionCable.server.broadcast "chatroom_#{result[:user_chatroom][:chatroom][:id]}:users", result
  end
end
