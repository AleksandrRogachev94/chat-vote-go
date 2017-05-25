module ApplicationCable
  class Channel < ActionCable::Channel::Base

    class NotAuthorizedError < StandardError
    end

    def find_and_authorize_chatroom
      chatroom = Chatroom.find_by(id: params[:chatroom_id])
      if !chatroom ||
         (chatroom.owner != current_user && !chatroom.guests.include?(current_user))
         raise NotAuthorizedError
       else
         chatroom
       end
    end
  end
end
