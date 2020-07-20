class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chats_#{params[:chat_id]}_channel"
  end

  def room
    Chat.find(params[:chat_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
