class UsersController < ApplicationController

  def index
    UserMailer.example(User.new(email: 'bo@samurails.com')).deliver
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to action: :index
    else
      render text: 'validation error'
    end 
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to action: :index
    else
      render edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :nickname)
  end
end