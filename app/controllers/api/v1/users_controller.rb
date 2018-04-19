class Api::V1::UsersController < ApplicationController

  def show
    if @user = User.find(params[:id])
      render json: @user
    else
      render json: @user.errors, status: :bad_request
    end
  end


  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_digest)
  end
end
