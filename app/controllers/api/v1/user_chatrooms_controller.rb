class Api::V1::UserChatroomsController < ApplicationController
  before_action :authenticate!
  before_action :set_chatroom_and_user, only: [:create, :destroy]

  def create
    user_chatroom = UserChatroom.new(user: @user, chatroom: @chatroom)
    if user_chatroom.save
      render json: user_chatroom, status: :created
    else
      render json: { errors: user_chatroom.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user_chatroom = UserChatroom.find_by(chatroom: @chatroom, user: @user)
    return render json: { errors: { other: ["Wrong input data"] } },
      status: :unprocessable_entity if !user_chatroom

    return forbidden_resource if @chatroom.owner != current_user

    user_chatroom.destroy
    render json: user_chatroom, status: :ok
  end

  private

    def set_chatroom_and_user
      @chatroom = Chatroom.find_by(id: params[:chatroom_id])
      @user = User.find_by(id: params[:user_id])

      return render json: { errors: { other: ["Wrong input data"] } },
        status: :unprocessable_entity if !@chatroom || !@user
    end
end
