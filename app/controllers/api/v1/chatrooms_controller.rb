class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate!
  before_action :set_chatroom, only: [:show, :destroy]

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
    render json: @chatroom, serializer: ChatroomSerializer, status: :ok
  end

  def create
    chatroom = Chatroom.new(chatroom_params)
    chatroom.owner = current_user

    if chatroom.save
      render json: chatroom, serializer: ChatroomBasicSerializer, status: :created
    else
      render json: { errors: chatroom.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return forbidden_resource if @chatroom.owner != current_user
    @chatroom.destroy
    render json: @chatroom, serializer: ChatroomBasicSerializer, status: :ok
  end

  private
    def chatroom_params
      params.require(:chatroom).permit(:title)
    end

    def set_chatroom
      @chatroom = Chatroom.find_by(id: params[:id])
      return render json: { errors: { other: ["This chatroom doesn't exist"] } },
        status: :not_found if !@chatroom
      return forbidden_resource if @chatroom.owner != current_user && !@chatroom.guests.include?(current_user)
    end
end
