require 'spec_helper'
require 'app/runners/hydramata/group_runners'

module Hydramata
  module GroupRunners #
    describe GroupRunners do
      Given(:context) { double('Context') }
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
    end
  end
end