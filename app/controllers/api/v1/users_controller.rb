class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :update]

  def show
    if @user = User.find(params[:id])
      render json: @user
    else
      render json: @user.errors0
    end
  end

  def index
    @user = current_user
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors , status: :bad_request
    end
  end

  def update
    @user = current_user
    if @user.update(email: user_params[:email])
      render json: @user
    else
      render json: @user.errors
    end
  end

private

  def user_params
    params.permit(:email, :password, :password_digest)
  end
end
