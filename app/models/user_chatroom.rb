class UserChatroom < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validate :owner_cant_be_guest

  def owner_cant_be_guest
    if self.chatroom.owner == self.user
      errors.add(:user, "is already an owner, can't be guest")
    end
  end
end
