require 'spec_helper'

module Hydramata::Deposit::WorksResponder
  describe Base do
    # @TODO - At this point, things are a bit fragile (not the number of mocks,
    # and the violation of the Law of Demeter. As this is fleshed out, we can
    # hopefully remove the custom responder (it is an artifact of connecting
    # things into Curate)
    let(:request) { double('Request', get?: get)}
    let(:get) { nil }
    let(:controller) { double('Controller', request: request, formats: [:html], hydramata_deposit: hydramata_deposit) }
    let(:resource) { double('Resource', work_type: 'article', to_param: "1234")}
    let(:hydramata_deposit) { double }
    subject { described_class.new(controller, [resource]) }
    let(:error) { RuntimeError.new }
    context '#navigation_behavior' do
      context 'get?' do
        let(:get) { true }
        it 'raises an error' do
          expect {
            subject.navigation_behavior(error)
          }.to raise_error(error)
        end
      end
      context 'get?' do
        let(:get) { false }
        it 'raises an error' do
          hydramata_deposit.should_receive(:edit_work_path).with(resource.to_param).and_return('/path/to/resource')
          subject.should_receive(:redirect_to).with {|path, options| path == '/path/to/resource' && options[:flash][:success] }
          subject.navigation_behavior(error)
        end
      end
    end
  end
end
