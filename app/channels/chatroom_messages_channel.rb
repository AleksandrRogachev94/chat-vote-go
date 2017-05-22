class ChatroomMessagesChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    return if !chatroom ||
              (chatroom.owner != current_user && !chatroom.guests.include?(current_user))

    stream_from "chatroom_#{params[:chatroom_id]}:messages"
  end

  def receive(payload)
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    return if !chatroom ||
              (chatroom.owner != current_user && !chatroom.guests.include?(current_user))

    message = Message.new(user: current_user, chatroom: chatroom,
                   content: payload['message']['content'])

    if message.save
      ActionCable.server.broadcast "chatroom_#{message.chatroom_id}:messages",
        ActiveModelSerializers::SerializableResource.new(message).as_json
    end
  end
end
