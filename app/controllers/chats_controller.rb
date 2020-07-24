class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: %w(show, edit, update, destroy)

  def index
    @chats = Chat.all
  end

  def show
  end

  def new
    @chat = Chat.new
      #render template: 'chats/new'
  end


  def edit
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.user_id = current_user.id
    if @chat.save!
      current_user.user_chats.create(chat_id: @chat.id, admin: true)
      flash[:success] = 'Chat create!'
      redirect_to new_message_path(chat_id: @chat.id)
    end
  end


  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to @chat, notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @chat.destroy
    ActionCable.server.broadcast 'remove_channel', content: @chat

    respond_to do |format|
      format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:title)
  end
end