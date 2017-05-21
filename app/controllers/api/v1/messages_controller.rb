class Api::V1::MessagesController < ApplicationController
  before_action :authenticate!

  def create
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    return render json: { errors: { other: ["This chatroom doesn't exist"] } },
      status: :unprocessable_entity if !chatroom

    return forbidden_resource if chatroom.owner != current_user && !chatroom.guests.include?(current_user)

    message = Message.new(message_params)
    message.user = current_user; message.chatroom = chatroom

    if message.save
      ActionCable.server.broadcast 'messages',
        ActiveModelSerializers::SerializableResource.new(message).as_json
      head :ok
    else
      render json: { errors: message.errors.messages }, status: :unprocessable_entity
    end
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end
end
