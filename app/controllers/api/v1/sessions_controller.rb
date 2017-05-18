class Api::V1::SessionsController < ApplicationController
  def login
    user = User.find_by(email: auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      jwt = Auth.issue({ id: user.id, nickname: user.nickname })
      render json: { jwt: jwt }, status: :created
    else
      render json: { errors: { auth: ["Invalid Credentials"] } }, status: :unauthorized
    end
  end

  private

    def auth_params
      params.require(:user).permit(:email, :password)
    end
end
