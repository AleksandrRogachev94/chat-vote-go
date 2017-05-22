class ChatroomSuggestionsChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    return if !chatroom ||
              (chatroom.owner != current_user && !chatroom.guests.include?(current_user))

    stream_from "chatroom_#{params[:chatroom_id]}:suggestions"
  end

  def receive(payload)
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    return if !chatroom ||
              (chatroom.owner != current_user && !chatroom.guests.include?(current_user))

    suggestion = Suggestion.new(user: current_user, chatroom: chatroom,
                   title: payload['suggestion']['title'], description: payload['suggestion']['description'])

    if suggestion.save
      ActionCable.server.broadcast "chatroom_#{suggestion.chatroom_id}:suggestions",
        ActiveModelSerializers::SerializableResource.new(suggestion).as_json
    end
  end
end
