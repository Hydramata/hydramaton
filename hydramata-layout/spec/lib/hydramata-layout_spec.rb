require 'spec_helper'

describe Hydramata do
  subject { described_class }

  context 'default configuration' do
    it 'has a layout.theme' do
      expect(described_class.configuration.layout.theme).to eq('hydramata')
    end
  end
end