class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create, :new]
  before_action :user

  def user
    @user = current_user
  end

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
    friend = User.find(params[:user_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      # render :index, status: :created, location: @friend_request
     redirect_to root_path
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @friend_request.accept
    
    redirect_to friendships_path
  end

  def destroy
    @friend_request.destroy
    
    redirect_to root_path
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
