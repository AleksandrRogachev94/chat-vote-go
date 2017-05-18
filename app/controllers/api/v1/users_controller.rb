class Api::V1::UsersController < ApplicationController
  before_action :authenticate!, only: [:index, :show]

  def signup
    user = User.new(user_params)
    if user.save
      jwt = Auth.issue({ id: user.id, email: user.email })
      render json: { jwt: jwt }, status: :created
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def index
    render json: User.all
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, status: :ok
    else
      render json: { errors: { other: ["This user does not exist"] } }, status: :not_found
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
