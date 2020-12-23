class ReportsUploader
  class << self
    REPORTS_FOLDER = './reports'.freeze

    def call
      upload_to_s3  if ::DevConfig.new.s3_enabled
      upload_to_gcs if ::DevConfig.new.gcs_enabled
      cleanup
    end

    private

    def upload_to_s3
      report_files_list.each do |file_path|
        ::Uploaders::Aws.new(File.expand_path(file_path)).call
      end
    end

    def upload_to_gcs
      report_files_list.each do |file_path|
        ::Uploaders::GoogleCloudStorage.new(File.expand_path(file_path)).call
      end
    end

    def report_files_list
      Dir[REPORTS_FOLDER]
    end

    def cleanup
      # TODO: remove uploaded local files if needed
    end
  end
end
