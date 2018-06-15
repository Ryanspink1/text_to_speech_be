require 'aws-sdk-s3'

class AmazonService
  def initialize(current_user, count, blob)
    @id            = current_user.id
    @file_name     = "#{count}.webm"
    @file_location = blob.tempfile.path
  end

  def self.upload(current_user, count, blob)
    aws = AmazonService.new(current_user, count, blob)
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
    obj = s3.bucket('rs-text-to-speech').object("#{@id}_#{@file_name}")
    obj.upload_file("#{@file_location}", {acl: 'public-read' })
    obj.public_url
  end
end
