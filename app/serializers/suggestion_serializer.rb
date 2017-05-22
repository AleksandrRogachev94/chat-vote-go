class SuggestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :api_link, :user_id, :chatroom_id
end
