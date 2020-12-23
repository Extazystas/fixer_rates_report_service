require 'spec_helper'

RSpec.describe Uploaders::Local do
  let(:service)   { described_class.new(file_path).call }
  let(:file_path) { 'file_path' }
end
