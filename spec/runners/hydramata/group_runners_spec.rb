require 'spec_helper'
require 'app/runners/hydramata/group_runners'

module Hydramata
  module GroupRunners #
    describe GroupRunners do
      Given(:user) { double('User')}
      Given(:group) { double('Group') }
      Given(:identifier) { '123' }
      Given(:context) { double('Context', current_user: user) }
      Given(:callback) { StubCallback.new }
      Given(:callback_config) { callback.configure(:success) }
      Given(:runner) {
        runner_class.new(context, &callback_config)
      }

      describe Index do
        Given(:runner_class) { Index }
        Given(:groups) { [] }
        When(:results) { runner.run }
        Then { expect(results).to eq([groups]) }
        And { callback.invoked == [:success, groups] }
      end

      describe Show do
        before(:each) do
          Hydramata::Group.should_receive(:find).with(identifier).and_return(group)
        end
        Given(:runner_class) { Show }
        When(:result) { runner.run(identifier) }
        Then { expect(result).to eq([group]) }
        And { callback.invoked == [:success, group] }
      end

      describe New do
        before(:each) do
          Hydramata::Group.should_receive(:new_form_for).with(user).and_return(group)
        end
        Given(:runner_class) { New }
        When(:result) { runner.run }
        Then { expect(result).to eq([group]) }
        And { callback.invoked == [:success, group] }
      end

      describe Edit do
        before(:each) do
          Hydramata::Group.should_receive(:existing_form_for).with(user, identifier).and_return(group)
        end
        Given(:runner_class) { Edit }
        When(:result) { runner.run(identifier) }
        Then { expect(result).to eq([group]) }
        And { callback.invoked == [:success, group] }
      end

      describe Create do
        before(:each) do
          Hydramata::Group.should_receive(:new_form_for).with(user).and_return(group)
        end
        Given(:parameters) { {} }
        Given(:runner_class) { Create }

        context 'success' do
          Given(:group) { double("Group", class: Hydramata::Group, :attributes= => true, :save => true)}
          Given(:message) { runner.success_message(group) }
          When(:result) { runner.run(parameters) }
          Then { expect(result).to eq([group, message]) }
          And { callback.invoked == [:success, group, message] }
          And { expect(group).to have_received(:attributes=).with(parameters) }
          And { expect(group).to have_received(:save) }
        end

        context 'failure' do
          Given(:group) { double("Group", :attributes= => true, :save => false)}
          Given(:parameters) { {} }
          Given(:runner_class) { Create }
          When(:result) { runner.run(parameters) }
          Then { expect(result).to eq([group]) }
          And { expect(group).to have_received(:attributes=).with(parameters) }
          And { expect(group).to have_received(:save) }
          And { callback.invoked == [:failure, group] }
        end
      end
    end
  end
end
