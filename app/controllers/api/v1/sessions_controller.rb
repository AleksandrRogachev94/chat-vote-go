class Api::V1::SessionsController < ApplicationController
  def login
    user = User.find_by(email: auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      jwt="123"
      render json: { jwt: jwt }, status: :created
    else
      render json: { errors: ["wrong jwt"] }, status: :unauthorized
    end
  end

  private

    def auth_params
      params.require(:user).permit(:email, :password)
    end
end
