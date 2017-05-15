class Api::V1::SessionsController < ApplicationController
  def login
    render json: {message: 'trying to log in...'}
  end
end
