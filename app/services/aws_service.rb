require 'aws-sdk-s3'

class AwsService
  def initialize(encoded_phrase)
    @file_name     = "#{encoded_phrase}.mp3"
    @file_location = "./public/conversions/#{encoded_phrase}.mp3"
  end

  def self.upload(encoded_phrase)
    aws = AwsService.new(encoded_phrase)
    aws.config
    aws.send_sound_file
  end

  def config
    Aws.config.update({
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
    })
  end

  def send_sound_file
    s3  = Aws::S3::Resource.new
    obj = s3.bucket('rs-text-to-speech').object("#{@file_name}")
    obj.upload_file("#{@file_location}", {acl: 'public-read' })
    obj.public_url
  end
end
