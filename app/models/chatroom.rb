class Chatroom < ApplicationRecord
  belongs_to :owner, class_name: User, foreign_key: 'user_id'

  has_many :user_chatrooms
  has_many :guests, through: :user_chatrooms, source: :user

  has_many :messages
  has_many :suggestions

  validates :title, presence: true
end
