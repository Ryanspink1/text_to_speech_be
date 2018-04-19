class Api::V1::Guest::ConversionsController < ApplicationController

  def index
    encoded_phrase = Conversion.save_to_public(conversion_params[:phrase])
    render json: {"file":
                   {"url ": "/public/conversions/#{encoded_phrase}.mp3"}
                 }
  end

private

  def conversion_params
    params.permit(:phrase)
  end
end
