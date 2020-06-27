class ChatController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  def index
    @chat = Chat.all
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.chat.build(chat_params)
    if @chat.save
      flash[:success] = 'Chat successfully added!'
      redirect_to chat_path
    else
      render 'new'
    end
  end

  def show
    @chat = Chat.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def destroy
    @chat.destroy
    respond_to do |format|
      format.html { redirect_to chat_url, notice: 'Chat was successfully destroyed.' }
      format.json { head :no_content }
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