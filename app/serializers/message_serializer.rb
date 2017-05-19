class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :chatroom_id, :created_at

  def created_at
    object.created_at.to_f * 1000 # convert to milliseconds since 1970-01-01 00:00:00 UTC.
  end
end
