class SuggestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :place_id_google, :user_id, :chatroom_id, :voters

  def voters
    object.evaluators_for(:votes).pluck(:id)
  end
end
