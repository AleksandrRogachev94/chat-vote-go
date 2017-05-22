class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :messages
  belongs_to :owner, serializer: UserBasicSerializer
  has_many :guests, serializer: UserBasicSerializer
  has_many :suggestions
end
