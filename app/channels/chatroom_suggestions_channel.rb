class ChatroomSuggestionsChannel < ApplicationCable::Channel
  def subscribed
    chatroom = find_and_authorize_chatroom
    stream_from "chatroom_#{params[:chatroom_id]}:suggestions"
    rescue NotAuthorizedError
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
    suggestion = Suggestion.new(user: current_user, chatroom: chatroom,
                   title: payload['suggestion']['title'], description: payload['suggestion']['description'],
                   place_id_google: payload['suggestion']['place_id_google'])

    if suggestion.save
      ActionCable.server.broadcast "chatroom_#{suggestion.chatroom_id}:suggestions",
        suggestion: SuggestionSerializer.new(suggestion).as_json
    end
  end

  def handle_vote(chatroom, suggestion)
    return if suggestion.has_evaluation?(:votes, current_user)

    prev = Suggestion.evaluated_by(:votes, current_user).select do |sug|
      sug.chatroom_id == suggestion.chatroom_id
    end
    prev.each { |sug| sug.delete_evaluation(:votes, current_user) }

    suggestion.add_evaluation(:votes, 1, current_user)

    ActionCable.server.broadcast "chatroom_#{suggestion.chatroom_id}:suggestions",
      suggestion: SuggestionSerializer.new(suggestion).as_json

    prev.each do |suggestion|
      ActionCable.server.broadcast "chatroom_#{suggestion.chatroom_id}:suggestions",
        suggestion: SuggestionSerializer.new(suggestion).as_json
    end
  end
end
