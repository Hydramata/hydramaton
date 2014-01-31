require 'spec_helper'

module Hydramata::Core
  describe Attachment do
    context '#attached', integration: true do
      subject { described_class.new(attached: File.new(__FILE__, 'rb')) }
      its(:attached_content_type) { should eq('application/x-ruby')}
    end
  end
end
