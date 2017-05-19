class Api::V1::MessagesController < ApplicationController
  before_action :authenticate!

  def create
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    return render json: { errors: { other: ["This chatroom doesn't exist"] } },
      status: :unprocessable_entity if !chatroom

    message = Message.new(message_params)
    message.user = current_user; message.chatroom = chatroom

    if message.save
      render json: message, status: :created
    else
      render json: { errors: message.errors.messages }, status: :unprocessable_entity
    end
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end
end
