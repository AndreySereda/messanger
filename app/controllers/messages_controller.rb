class MessagesController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @messages = Message.all
    @message = Message.new
  end

  # GET /chats/1/edit
  def edit
  end


  def create
    @message = Message.new
    chat = @message.chat_id
    if @message.save
    ChatChannel.broadcast_to chat,
                             body: @message.to_s,
                             user: @message.user.name
    else
      flash.now[:error] = "Somebody don't work!"
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @message.destroy
    ActionCable.server.broadcast 'remove_message', content: @message

    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Messages was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
  def set_chat
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:text)
  end
end