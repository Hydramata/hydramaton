require 'spec_helper'

module Hydramata::Core
  describe WorkDraft do
    context '.fetch_work_type_by_pid' do
      let(:pid) { '1234' }
      let(:work_type) { 'article' }
      before(:each) do
        Hydramata::Core::WorkDraft.create(pid: pid, work_type: work_type)
      end
      subject { described_class }
      it 'returns the work_type if the object exists' do
        expect(described_class.fetch_work_type_by_pid(pid)).to eq(work_type)
      end

      it 'raises an error if the object does not exist' do
        expect {
          described_class.fetch_work_type_by_pid(pid + '-not-found')
        }.to raise_error
      end
    end
  end
end