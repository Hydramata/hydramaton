require 'spec_helper'
require 'app/runners/hydramata/group_runners'

module Hydramata
  module GroupRunners #
    describe GroupRunners do
      Given(:user) { double('User')}
      Given(:group) { double('Group') }
      Given(:identifier) { '123' }
      Given(:services) { double }
      Given(:context) { double('Context', current_user: user, services: services) }
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
        Given(:services) { double('Service', new_group_for: group)}
        Given(:attributes) { {} }
        Given(:runner_class) { New }
        When(:result) { runner.run(attributes) }
        Then { expect(result).to eq([group]) }
        And { callback.invoked == [:success, group] }
        And { expect(services).to have_received(:new_group_for).with(user, attributes) }
      end

      describe Create do
        Given(:attributes) { {} }
        Given(:runner_class) { Create }
        Given(:services) { double('Service', new_group_for: group, save_group: save_was_successful?) }
        Given(:group) { double("Group", class: Hydramata::Group)}

        context 'success' do
          Given(:save_was_successful?) { true }
          Given(:message) { runner.success_message(group) }
          When(:result) { runner.run(attributes) }
          Then { expect(result).to eq([group, message]) }
          And { callback.invoked == [:success, group, message] }
          And { expect(services).to have_received(:new_group_for).with(user, attributes) }
          And { expect(services).to have_received(:save_group).with(group, creators: user) }
        end

        context 'failure' do
          Given(:save_was_successful?) { false }
          When(:result) { runner.run(attributes) }
          Then { expect(result).to eq([group]) }
          And { callback.invoked == [:failure, group] }
          And { expect(services).to have_received(:new_group_for).with(user, attributes) }
          And { expect(services).to have_received(:save_group).with(group, creators: user) }
        end
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

      describe Update do
        before(:each) do
          Hydramata::Group.should_receive(:existing_form_for).with(user, identifier).and_return(group)
        end
        Given(:attributes) { {} }
        Given(:group) { double('Group', class: Hydramata::Group, update: update_was_successful?)}
        Given(:runner_class) { Update }

        context 'success' do
          Given(:update_was_successful?) { true }
          Given(:message) { runner.success_message(group) }
          When(:result) { runner.run(identifier, attributes) }
          Then { expect(result).to eq([group, message]) }
          And { expect(group).to have_received(:update).with(attributes) }
          And { callback.invoked == [:success, group, message] }
        end
        context 'failure' do
          Given(:update_was_successful?) { false }
          When(:result) { runner.run(identifier, attributes) }
          Then { expect(result).to eq([group]) }
          And { expect(group).to have_received(:update).with(attributes) }
          And { callback.invoked == [:failure, group] }
        end
      end

      describe Destroy do
        Given(:services) { double('Service', find_group: group)}
        Given(:runner_class) { Destroy }
        Given(:group) { double('Group', destroy: true) }
        When(:result) { runner.run(identifier) }
        Then { expect(result).to eq([group]) }
        And { expect(group).to have_received(:destroy) }
        And { callback.invoked == [:success, group] }
      end

    end

  end
end
