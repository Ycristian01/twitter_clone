class TweetsController < ApplicationController
  before_action :set_user
  before_action :set_tweet, only: %i[ show edit update destroy ]

  def show
  end

  def new
   @tweet = @user.tweets.new 
  end

  def edit
  end

  def create
   @tweet = @user.tweets.create(tweet_params)

    if @tweet.save
      redirect_to user_tweet_path @user, @tweet
      flash[:notice] = "Tweet was successfully created"
    else
      render 'new'
    end
  end

  def update
    if @tweet.update(tweet_params) 
      redirect_to user_tweet_path @user
      flash[:notice] = "Tweet was successfully updated." 
    else
      render 'edit'
    end   
  end

  def destroy
   @tweet.destroy

   redirect_to username_path(current_user.username)
   flash[:notice] = "Tweet was successfully destroyed." 
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
      
    def set_tweet
      @tweet = @user.tweets.find(params[:id]) 
    end

    def tweet_params
      params.require(:tweet).permit(:post) 
    end

end
