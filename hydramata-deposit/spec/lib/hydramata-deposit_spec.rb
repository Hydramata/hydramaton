require 'spec_helper'

module Hydramata
  describe Deposit do
    context '.new_form_for' do
      let(:local_configuration) { double('Configuration') }
      let(:work_type) { 'article' }
      let(:form_config) { double }
      let(:finalizer) { double }
      let(:controller) { double }
      let(:klass) { Class.new { def initialize(controller); end } }
      it 'should fetch a finalized form' do
        local_configuration.should_receive(:new_form_for).with(work_type).and_return(form_config)
        finalizer.should_receive(:call).with(work_type, form_config).and_return(klass)

        expect(
          Hydramata::Deposit.new_form_for(controller, work_type, finalizer: finalizer, config: local_configuration)
        ).to be_an_instance_of(klass)
      end
    end
  end
end