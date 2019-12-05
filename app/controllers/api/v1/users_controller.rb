class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:profile, :show, :create] # all routes protected EXCEPT #create

  def profile
    # render json: { user: UserSerializer.new(current_user)}, status: :accepted
    puts current_user
    render json: { user: {id: current_user.id, username: current_user.username}}, status: :accepted
  end

  def index
    @users = User.all
    render json: @users
  end



  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id) # token is issued and assigned when new user is created
      render json: {user: UserSerializer.new(@user), jwt: @token}, status: :created
    else
      render json: {error: 'failed to create user'}, status: :not_acceptable
    end
  end





  def show
    @user = User.find(params[:id])
    render json: {user: UserSerializer.new(@user)}, status: :ok
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      render json: @user
    else
      render json: {error: @user.errors.full_messages}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: {message:"User Deleted"}
  end



  private

  # t.string "user_locations"
  # t.string "user_industries"
  # t.string "user_categories"
  # t.string "user_levels"

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end