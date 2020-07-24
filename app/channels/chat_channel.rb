class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:chat_id]}"
  end

  def chat
    Chat.find(params[:chat_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
