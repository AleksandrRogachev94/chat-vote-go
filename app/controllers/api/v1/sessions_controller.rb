class Api::V1::SessionsController < ApplicationController
  def login
    user = User.find_by(email: auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      jwt = Auth.issue({ user_id: user.id, user_email: user.email })
      render json: { jwt: jwt }, status: :created
    else
      render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
  end

  private

    def auth_params
      params.require(:user).permit(:email, :password)
    end
end
