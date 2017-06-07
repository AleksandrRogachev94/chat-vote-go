class UserChatroom < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validate :owner_cant_be_guest, :guests_are_unique

  after_create_commit { UserChatroomBroadcastJob.perform_later self }

  after_destroy :destroy_chatroom_suggestions_and_votes_and_messages
  after_destroy_commit { UserChatroomRemoveBroadcastJob.perform_later ActiveModelSerializers::SerializableResource.new(self).as_json }

  def owner_cant_be_guest
    if self.chatroom.owner == self.user
      errors.add(:user, "is already an owner, can't be guest")
    end
  end

  def guests_are_unique
    if self.chatroom.guests.include?(self.user)
      errors.add(:user, "is already a guest")
    end
  end

  def destroy_chatroom_suggestions_and_votes_and_messages
    self.chatroom.suggestions.where(user: self.user).destroy_all
    # self.chatroom.messages.where(user: self.user).destroy_all
    self.chatroom.suggestions.each do |sug|
      if sug.has_evaluation?(:votes, self.user)
        sug.delete_evaluation(:votes, self.user)
      end
    end
  end
end
