class SuggesionsController < ApplicationController
  def create
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    return render json: { errors: { other: ["This chatroom doesn't exist"] } },
      status: :unprocessable_entity if !chatroom

    return forbidden_resource if chatroom.owner != current_user && !chatroom.guests.include?(current_user)

    suggestion = Message.new(suggestion_params)
    suggestion.user = current_user; suggestion.chatroom = chatroom

    if suggestion.save
      # ActionCable.server.broadcast 'messages',
      #   ActiveModelSerializers::SerializableResource.new(message).as_json
      # head :ok

      render json: { notification: "success" }, status: :ok
    else
      render json: { errors: suggestion.errors.messages }, status: :unprocessable_entity
    end
  end

  private

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :api_link)
    end
end
