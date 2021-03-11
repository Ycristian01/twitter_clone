class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy followview ]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end
 
  def new
    @user = User.new
  end

  def followview
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
      flash[:notice] = "User was successfully created"      
    else
      render 'new'     
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "User was successfully updated." 
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
    flash[:notice] = "User was successfully destroyed." 
  end

  def follow
    @user = User.find(params[:id])
    current_user.followings << @user
    redirect_back(fallback_location: users_path)
  end
  
  def unfollow
    @user = User.find(params[:id])
    current_user.given_follows.find_by(followed_user_id: @user.id).destroy
    redirect_back(fallback_location: users_path)
  end

end

private

    def set_user
      @user = User.find_by(username: params[:username])
    end

    def user_params
      params.require(:user).permit(:name, :username)
    end