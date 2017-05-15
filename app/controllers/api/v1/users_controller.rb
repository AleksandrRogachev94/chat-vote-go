class Api::V1::UsersController < ApplicationController
  before_action :authenticate!, only: [:test]

  def signup
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
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
