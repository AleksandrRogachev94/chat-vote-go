class Api::V1::UserChatroomsController < ApplicationController
  before_action :authenticate!

  def create
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    user = User.find_by(id: params[:user_id])

    return render json: { errors: { other: ["Wrong input data"] } },
      status: :unprocessable_entity if !chatroom || !user
    user_chatroom = UserChatroom.new(user: user, chatroom: chatroom)

    if user_chatroom.save
      render json: user_chatroom, status: :created
    else
      render json: { errors: user_chatroom.errors.messages }, status: :unprocessable_entity
    end
  end
end
