class Api::V1::UsersController < ApplicationController
  def signup
    render json: {message: 'trying to sign up...'}
  end
end
