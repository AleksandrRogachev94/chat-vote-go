class Api::V1::SuggestionsController < ApplicationController
  before_action :authenticate!
  before_action :set_suggestion, only: [:destroy]

  def destroy
    @suggestion.delete
    render json: @suggestion, status: :ok
  end

  private

    def set_suggestion
      @suggestion = Suggestion.find_by(id: params[:id])
      return render json: { errors: { other: ["This suggestion doesn't exist"] } },
        status: :not_found if !@suggestion
      chatroom = @suggestion.chatroom
      return forbidden_resource if chatroom.owner != current_user
    end
end
