class ChatroomUsersChannel < ApplicationCable::Channel
  def subscribed
    chatroom = find_and_authorize_chatroom
    stream_from "chatroom_#{params[:chatroom_id]}:users"
    rescue NotAuthorizedError
      reject
  end

  def receive(payload)
    chatroom = find_and_authorize_chatroom
    user = User.find_by(id: payload['user_id'])
    return if !user

    UserChatroom.create(user: user, chatroom: chatroom)

    rescue NotAuthorizedError
  end

  def remove(payload)
    chatroom = find_and_authorize_chatroom
    user = User.find_by(id: payload['user_id'])
    return if !user || user == chatroom.owner || chatroom.owner != current_user

    user_chatroom = UserChatroom.find_by(chatroom: chatroom, user: user)
    return if !user_chatroom

    user_chatroom.destroy
    rescue NotAuthorizedError
  end
end
