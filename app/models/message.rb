class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  after_create_commit { MessageBroadcastJob.perform_later self }

  validates :content, presence: true
end
