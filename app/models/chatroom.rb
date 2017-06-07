class Chatroom < ApplicationRecord
  belongs_to :owner, class_name: User, foreign_key: 'user_id'

  has_many :user_chatrooms, dependent: :destroy
  has_many :guests, through: :user_chatrooms, source: :user

  has_many :messages, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates :title, presence: true
end
