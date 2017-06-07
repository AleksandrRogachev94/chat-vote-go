class ChatroomSuggestionsChannel < ApplicationCable::Channel
  def subscribed
    chatroom = find_and_authorize_chatroom
    stream_from "chatroom_#{params[:chatroom_id]}:suggestions"
    rescue NotAuthorizedError
      reject
  end

  def receive(payload)
    chatroom = find_and_authorize_chatroom
    suggestion = Suggestion.find_by(id: payload['suggestion_id'])

    if chatroom && suggestion # vote
      handle_vote(chatroom, suggestion)
    elsif chatroom # create suggustion
      handle_new_suggestion(chatroom, payload)
    end

    rescue NotAuthorizedError
  end

  def handle_new_suggestion(chatroom, payload)
    Suggestion.create(user: current_user, chatroom: chatroom,
                   title: payload['suggestion']['title'], description: payload['suggestion']['description'],
                   place_id_google: payload['suggestion']['place_id_google'])
  end

  def handle_vote(chatroom, suggestion)
    return if suggestion.has_evaluation?(:votes, current_user)

    prev = Suggestion.evaluated_by(:votes, current_user).select do |sug|
      sug.chatroom_id == suggestion.chatroom_id
    end
    prev.each { |sug| sug.delete_evaluation_with_broadcasting(:votes, current_user) }

    suggestion.add_evaluation_with_broadcasting(:votes, 1, current_user)
  end
end
