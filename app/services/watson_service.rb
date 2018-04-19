class WatsonService

  def initialize(phrase)
    @username = ENV["watson_username"]
    @password = ENV["watson_password"]
    @voice = "en-US_AllisonVoice"
    @connection = Faraday.new("https://stream.watsonplatform.net/text-to-speech/api/v1/synthesize?accept=audio/mp3&text=#{phrase}&voice=#{@voice}") do |conn|
      conn.basic_auth("#{@username}", "#{@password}")
      conn.adapter  Faraday.default_adapter
    end
  end

  def self.get(phrase)
    speech = WatsonService.new(phrase)
    speech.get_watson_data
  end

  def get_watson_data
    response = @connection.get
    response.body
  end
end
