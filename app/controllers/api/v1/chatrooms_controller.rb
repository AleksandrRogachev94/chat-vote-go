class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate!

  def index
    case params[:type]
    when "own"
      render json: current_user.own_chatrooms, each_serializer: ChatroomBasicSerializer, status: :ok
    when "guest"
      render json: current_user.guest_chatrooms, each_serializer: ChatroomBasicSerializer, status: :ok
    else
      render json: { errors: { other: ["Incorrect query"] } }, status: :bad_request
    end
  end

  def show
    chatroom = Chatroom.find_by(id: params[:id])
    return render json: { errors: { other: ["This chatroom doesn't exist"] } },
      status: :not_found if !chatroom
    if chatroom.owner != current_user && !chatroom.guests.include?(current_user)
      forbidden_resource
    end

    render json: chatroom, serializer: ChatroomSerializer, status: :ok
  end
end
