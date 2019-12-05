class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]
  require 'securerandom'

  def create
    puts params
    @user = User.find_by(username: params[:user][:username]) # returns either user instance OR nil
    if @user && @user.authenticate(user_params[:password]) #@user.#authenticate comes from BCrypt
      @token = encode_token({user_id: @user.id})
      # UserSerializer.show({user: @user, jwt: @token})
      render json: {user: UserSerializer.new(@user), jwt: @token}, status: :accepted

    else
      render json: {message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def create_secure_password
    SecureRandom.hex(10)
  end


end