class Api::V1::UsersController < ApplicationController
  before_action :authenticate!, only: [:test, :show]

  def signup
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, status: :ok
    else
      render json: { errors: { other: ["This user does not exist"] } }, status: :not_found
    end
  end

  def test
    render json: { message: "You're in business!!!", user: current_user }
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
