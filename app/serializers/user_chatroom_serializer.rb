class UserChatroomSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :user, serializer: UserBasicSerializer
  belongs_to :chatroom, serializer: ChatroomBasicSerializer
end
