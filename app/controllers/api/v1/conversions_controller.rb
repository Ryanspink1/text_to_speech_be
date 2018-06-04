class Api::V1::ConversionsController < ApplicationController
  before_action :authenticate_user, only: [:index, :create, :destroy]

  def index
    @user = current_user
    render json: @user.conversions
  end

  def create
    encoded_phrase = Conversion.save_to_public(conversion_params)
    @conversion    = current_user.conversions.new(voice: conversion_params[:voice],
                                                  text: conversion_params[:text],
                                                  aws_location: "https://s3-us-west-2.amazonaws.com/rs-text-to-speech/#{current_user.id}_#{encoded_phrase}.mp3")
    if @conversion.save
      AwsService.upload(encoded_phrase, current_user)
      render json: [@conversion], status: :created
    else
      render json: @conversion.errors, status: :bad_request
    end
  end

  def destroy
    @conversion = current_user.conversions.find_by(id: conversion_params[:id])
    if @conversion.delete
      render status: 200
    else
      render json: @conversion.errors, status: :bad_request
    end
  end

  private

  def conversion_params
    params.permit(:voice, :text, :id)
  end
end
