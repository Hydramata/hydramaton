require 'spec_helper'

module Hydramata
  describe Deposit do
    let(:local_configuration) { double('Configuration') }
    let(:work_type) { 'article' }
    let(:form_config) { double }
    let(:finalizer) { double }
    let(:controller) { double }
    let(:new_form_for_config) { {'article' => form_config } }
    let(:work_type_class) {
      Class.new {
        attr_reader :controller, :identifier
        def initialize(controller, identifier = nil)
          @controller = controller
          @identifier = identifier
        end
      }
    }

    context '.new_form_for' do
      let(:options) { {finalizer: finalizer, config: local_configuration} }
      subject { Hydramata::Deposit.new_form_for(controller, work_type, options) }
      before(:each) do
        local_configuration.should_receive(:new_form_for).and_return(new_form_for_config)
        finalizer.should_receive(:call).with(work_type, form_config).and_return(work_type_class)
      end
      its(:controller) { should eq(controller) }
      its(:identifier) { should be_nil }
    end

    context '.existing_form_for' do
      let(:identifier) { '1234' }
      let(:work_type_finder) { lambda {|id| work_type } }
      let(:options) { {finalizer: finalizer, config: local_configuration, work_type_finder: work_type_finder} }
      subject { Hydramata::Deposit.existing_form_for(controller, identifier, options) }
      before(:each) do
        local_configuration.should_receive(:new_form_for).and_return(new_form_for_config)
        finalizer.should_receive(:call).with(work_type, form_config).and_return(work_type_class)
      end
      its(:controller) { should eq(controller) }
      its(:identifier) { should eq(identifier) }
    end
  end
end
