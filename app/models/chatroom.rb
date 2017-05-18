class Chatroom < ApplicationRecord
  belongs_to :owner, class_name: User, foreign_key: 'user_id'
  has_many :messages

  validates :title, presence: true
end
