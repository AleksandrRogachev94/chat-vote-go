require_dependency 'auth'

class Api::V1::UsersController < ApplicationController
  before_action :authenticate!, only: [:index, :show, :update]

  def signup
    user = User.new(user_params)
    if user.save
      jwt = Auth.issue({ id: user.id, nickname: user.nickname })
      render json: { jwt: jwt }, status: :created
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by(id: params[:id])
    return render json: { errors: { other: ["This user doesn't exist"] } },
      status: :not_found if !user
    if user.update(user_params)
      jwt = Auth.issue({ id: user.id, nickname: user.nickname })
      render json: { jwt: jwt }, status: :ok
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def index
    render json: User.all, each_serializer: UserBasicSerializer, status: :ok
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, serializer: UserProfileSerializer, status: :ok
    else
      render json: { errors: { other: ["This user does not exist"] } }, status: :not_found
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :email, :nickname, :password, :password_confirmation, :avatar, :first_name, :last_name
      )
    end
end
