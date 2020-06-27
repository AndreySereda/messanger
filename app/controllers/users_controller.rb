class UsersController < ApplicationController
#POST
def create
  @user = User.new(user_params)
  if @user.save
    redirect_to action: :index
  else
    render 'validation error'
  end
end

#GET
def new
  @user = User.new
end

#GET
def show
  @user = User.find(params[:id])
end

#GET - поиск всех users
def index
  UserMailer.example(User.new(email: 'bo@samurails.com')).deliver
  @users = User.all
end

#GET
def edit
  @user = User.find(params[:id])
end

#PUT/PATCH
def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    redirect_to action: :index
  else
    render edit
  end
end

#DELETE
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
  params.require(:user).permit(:first_name, :last_name, :nickname)
end
end