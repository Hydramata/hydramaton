require 'spec_helper'

module Hydramata
  describe Configuration do
    subject { described_class.new }
    let(:value) { double }
    let(:deep_value) { double }
    before(:each) do
      subject.key = value
      subject.deep.seeded.key = deep_value
    end

    context 'unlocked' do

      it 'has keys' do
        expect(subject.keys).to eq([:key, :deep])
      end

      it 'has a friendly inspect' do
        expect(subject.inspect).to eq({key: value, deep: {seeded: { key: deep_value}}}.inspect)
      end

      it 'handles deeply nested configuration' do
        expect(subject[:deep][:seeded][:key]).to eq(deep_value)
      end

      it 'retrieve the value based on various key accesses' do
        expect(subject.key).to eq(value)
        expect(subject.fetch(:key)).to eq(value)
        expect(subject.fetch('key')).to eq(value)
        expect(subject.key).to eq(value)
        expect(subject['key']).to eq(value)
        expect(subject[:key]).to eq(value)
      end

      it 'returns nil when retrieving a non-existent key' do
        expect(subject.fetch(:not_a_key)).to be_nil
        expect(subject.fetch('not_a_key')).to be_nil
        expect(subject.not_a_key).to be_nil
        expect(subject['not_a_key']).to be_nil
        expect(subject[:not_a_key]).to be_nil

        # This is an odd duck in Configatron's implementation. Not that
        # it returns a Configatron::Store, because that is how it chains
        # configuration. But because it doesn't return a similar class as
        # the implementing class.
        expect(subject.not_a_key).to be_a_kind_of(Configatron::Store)
      end

    end

    context 'locked' do
      before(:each) do
        subject.lock!
      end

      it 'retrieve the value based on various key accesses' do
        expect(subject.fetch(:key)).to eq(value)
        expect(subject.fetch('key')).to eq(value)
        expect(subject.key).to eq(value)
        expect(subject['key']).to eq(value)
        expect(subject[:key]).to eq(value)
      end

      it 'returns nil when retrieving a non-existent key' do
        expect { subject.fetch(:not_a_key) }.to raise_error
        expect { subject.fetch('not_a_key') }.to raise_error
        expect { subject.not_a_key }.to raise_error
        expect { subject['not_a_key'] }.to raise_error
        expect { subject[:not_a_key] }.to raise_error
      end

    end
  end
end
