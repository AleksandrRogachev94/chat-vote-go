class ChatroomMessagesChannel < ApplicationCable::Channel
  def subscribed
    chatroom = find_and_authorize_chatroom
    stream_from "chatroom_#{params[:chatroom_id]}:messages"
    rescue NotAuthorizedError
      reject
  end

  def receive(payload)
    chatroom = find_and_authorize_chatroom

    Message.create(user: current_user, chatroom: chatroom,
                   content: payload['message']['content'])

    rescue NotAuthorizedError
  end
end
