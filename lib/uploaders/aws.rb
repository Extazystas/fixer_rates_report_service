require 'aws-sdk-s3'

module Uploaders
  class Aws
    attr_reader :file_path, :bucket_name, :s3

    def initialize(file_path)
      @file_path   = file_path
      @bucket_name = ::AwsConfig.new.storage_bucket
      @s3          = ::Aws::S3::Client.new(region: AwsConfig.new.region)
    end

    def call
      check_if_bucket_exist

      upload_file
    end

    private

    def check_if_bucket_exist
      buckets = s3.list_buckets.buckets

      s3.create_bucket(bucket: bucket_name) if buckets.none? { |b| b.name == bucket_name }
    end

    def upload_file
      puts "Uploading file #{file_name} to bucket #{bucket_name}..."

      s3.put_object(
        bucket: bucket_name,
        key: file_name,
        body: IO.read(file_path)
      )
    end

    def file_name
      File.basename(file_path)
    end
  end
end
