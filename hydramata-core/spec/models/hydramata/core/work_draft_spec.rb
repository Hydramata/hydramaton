require 'spec_helper'

module Hydramata::Core
  describe WorkDraft do
    let(:work_type) { 'article' }
    let(:pid) { '1234' }

    context '.fetch_work_type_by_pid' do
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

    context '.query' do
      let(:controller) { double(:controller) }
      let(:parameters) { { work_type: work_type} }
      let(:other_work_type) { 'generic_work' }
      let(:other_pid) { '1234' }

      let!(:work_1) { Hydramata::Core::WorkDraft.create(pid: pid, work_type: work_type) }
      let!(:work_2) { Hydramata::Core::WorkDraft.create(pid: other_pid, work_type: other_work_type) }

      subject { described_class }
      it 'returns the work_type if the object exists' do
        expect(subject.query(controller, parameters)).to eq([work_1])
      end
    end
  end
end
