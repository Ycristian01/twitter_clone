class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy followview ]

  def index
    @users = User.all
    if user_signed_in?
      current_followings = current_user.followings
      @tweets = current_user.tweets
      current_followings.each do |following_user|
        @tweets = @tweets.or(following_user.tweets)
      end
      @tweets = @tweets.order([created_at: :desc]).paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @tweets = @user.tweets
    @tweets = @tweets.order([created_at: :desc]).paginate(page: params[:page], per_page: 10)
  end

  def edit
  end
 
  def new
    @user = User.new
  end

  def followview
    # @user_followers = @user.followers
    # @user_followers = @user_followers.order([name: :asc])

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