require 'spec_helper'

describe Hydramata do
  subject { described_class }

  context 'default configuration' do
    it 'has a layout.theme' do
      expect(described_class.configuration.layout.theme).to eq('hydramata')
    end
  end

  context '.configure' do
    around(:each) do |example|
      old_configuration = Hydramata.configuration
      Hydramata.configuration = nil
      example.run
      Hydramata.configuration = old_configuration
    end
    context 'default behavior' do
      it 'should yield a Configuration by default' do
        expect { |block| Hydramata.configure(&block)}.to yield_with_args(Hydramata::Configuration)
      end
    end

    context 'with an alternate configuration' do
      let(:config) { double }
      before(:each) do
        Hydramata.configuration = config
      end
      its(:config) { should eq Hydramata.configuration }
      it 'should yield the specified configuration object' do
        expect { |block| Hydramata.configure(&block)}.to yield_with_args(config)
      end
    end
  end
end
