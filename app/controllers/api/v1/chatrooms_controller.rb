class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate!

  def index
    case params[:type]
    when "own"
      render json: current_user.own_chatrooms, each_serializer: ChatroomBasicSerializer, status: :ok
    when "guest"
      render json: current_user.guest_chatrooms, each_serializer: ChatroomBasicSerializer, status: :ok
    else
      render json: { errors: { other: ["Incorrect query"] } }
    end
  end

  def show
    chatroom = Chatroom.find_by(id: params[:id])
    return render json: { errors: { other: ["This chatroom doesn't exist"] } } if !chatroom
    if chatroom.owner != current_user && !chatroom.guests.include?(current_user)
      return render json: { errors: { other: ["Not Authorized"] } }
    end

    render json: chatroom, serializer: ChatroomSerializer, status: :ok
  end
end
