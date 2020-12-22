require 'google/cloud/storage'

Google::Cloud::Storage.configure do |config|
  config.project_id  = GCSConfig.new.project_id
  config.credentials = GCSConfig.new.credentials
end

module Uploaders
  class GoogleCloudStorage
    attr_reader :file_path, :bucket

    def initialize(file_path)
      storage    = ::Google::Cloud::Storage.new
      @file_path = file_path
      @bucket    = storage.bucket ::GCSConfig.new.storage_bucket
    end

    def call
      bucket.create_file file_path, 'destination/path/file.ext'
    end
  end
end
