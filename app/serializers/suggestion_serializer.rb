class SuggestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :api_link, :user_id, :chatroom_id, :votes

  def votes
    object.reputation_for(:votes).to_i
  end
end
