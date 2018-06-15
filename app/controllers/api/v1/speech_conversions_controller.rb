class Api::V1::SpeechConversionsController < ApplicationController
  before_action :authenticate_user, only: [:index, :create]

  def index
    @speech_conversions = current_user.speech_conversions
    render json: @speech_conversions, status: :ok
  end

  def create
    conversion = SpeechService.post(params[:audio])
    count      = SpeechConversion.get_count ||= 1
    @speech_conversion = current_user.speech_conversions.new(text:         conversion["transcript"],
                                                             confidence:   conversion["confidence"],
                                                             aws_location: "https://s3-us-west-2.amazonaws.com/rs-text-to-speech/#{current_user.id}_#{count}.webm")
    if @speech_conversion.save
      AmazonService.upload(current_user, count, params[:audio])
      render json: @speech_conversion status: :created
    else
      render json: @speech_conversion.errors status: :bad_request
    end
  end

  def destroy
    @speech_conversion = current_user.speech_conversions.find(speech_conversion_params[:id])
    if @speech_conversion.delete
      render status: :no_content
    else
      render json: @speech_conversion.errors status: :bad_request
    end
  end
private
  def speech_conversion_params
    params.permit(:audio, :id)
  end
end
