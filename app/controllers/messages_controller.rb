class MessagesController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
  end

  # GET /chats/new
  def new
    @messages = Message.all
    @message = Message.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats
  # POST /chats.json
  def create
    room = @message.room
    RoomChannel.broadcast_to room,
                             body: @message.body,
                             user: @message.user.name


  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
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
  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:text)
  end
end