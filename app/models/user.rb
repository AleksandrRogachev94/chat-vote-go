class User < ApplicationRecord
  has_secure_password

  has_many :own_chatrooms, class_name: Chatroom, dependent: :destroy

  has_many :user_chatrooms
  has_many :guest_chatrooms, through: :user_chatrooms, source: :chatroom

  has_attached_file :avatar, default_url: 'https://s3.amazonaws.com/chat-vote-go-production/users/avatars/default_original.jpg', styles: { thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes

  before_save :capitalize_name

  validates :email, :nickname, presence: true, uniqueness: true

  def capitalize_name
    self.first_name.capitalize! if self.first_name
    self.last_name.capitalize! if self.last_name
  end
end
