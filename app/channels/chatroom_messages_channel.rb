class ChatroomMessagesChannel < ApplicationCable::Channel
  def subscribed
    chatroom = find_and_authorize_chatroom
    stream_from "chatroom_#{params[:chatroom_id]}:messages"
    rescue NotAuthorizedError
  end

  def receive(payload)
    chatroom = find_and_authorize_chatroom

    Message.create(user: current_user, chatroom: chatroom,
                   content: payload['message']['content'])

    # if message.save
    #   ActionCable.server.broadcast "chatroom_#{message.chatroom_id}:messages",
    #     ActiveModelSerializers::SerializableResource.new(message).as_json
    # end

    rescue NotAuthorizedError
  end
end
