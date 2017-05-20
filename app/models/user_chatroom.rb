class UserChatroom < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validate :owner_cant_be_guest, :guests_are_unique

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
end
