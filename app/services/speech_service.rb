class SpeechService
  attr_reader :request,
              :uri,
              :req_options

  def initialize
    @uri = URI.parse("https://stream.watsonplatform.net/speech-to-text/api/v1/recognize?")
    @request = Net::HTTP::Post.new(uri)
    @req_options = {
      use_ssl: uri.scheme == "https"
      }
  end

  def self.post(blob)
    speech = SpeechService.new
    speech.set_params(blob)
    speech.post_to_watson
  end

  def set_params(blob)
    request.basic_auth(ENV["SPEECH_TO_TEXT_USERNAME"], ENV["SPEECH_TO_TEXT_PASSWORD"])
    request.content_type = "audio/webm"
    request.body = ""
    request.body << File.read(blob.tempfile)
  end

  def post_to_watson
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    JSON.parse(response.body)["results"][0]["alternatives"][0]
  end
end
