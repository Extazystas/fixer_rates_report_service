require 'spec_helper'

RSpec.describe ReportsUploader do
  let(:service) { described_class }

  before do
    allow(ReportsUploader).to receive(:report_files_list).and_return(['fake_report_file.html'])
  end

  context 'when S3 and GCS enabled' do
    before do
      allow_any_instance_of(DevConfig).to receive(:s3_enabled).and_return true
      allow_any_instance_of(DevConfig).to receive(:gcs_enabled).and_return true
    end

    it do
      expect(::Uploaders::Aws).to receive(:new).and_return(double(call: true))
      expect(::Uploaders::GoogleCloudStorage).to receive(:new).and_return(double(call: true))

      service.call
    end
  end

  context 'when S3 and GCS disabled' do
    before do
      allow_any_instance_of(DevConfig).to receive(:s3_enabled).and_return false
      allow_any_instance_of(DevConfig).to receive(:gcs_enabled).and_return false
    end

    it do
      expect(::Uploaders::Aws).not_to receive(:new)
      expect(::Uploaders::GoogleCloudStorage).not_to receive(:new)

      service.call
    end
  end
end
