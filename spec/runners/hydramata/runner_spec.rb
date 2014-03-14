require 'fast_helper'
require 'hydramata/runner'

module Hydramata

  describe Runner do
    Given(:context) { double(invoked: true) }
    Given(:runner) {
      Runner.new(context) do |on|
        on.success { |a, b| context.invoked("SUCCESS", a, b) }
        on.failure { |a, b| context.invoked("FAILURE", a, b) }
        on.other   { |a, b| context.invoked("OTHER", a, b) }
      end
    }

    Invariant { runner.context == context }

    describe "#run" do
      When(:response) { runner.run }
      Then { expect(response).to have_raised(NotImplementedError) }
    end

    describe "calling other" do
      When(:result) { runner.callback(:other, :first, :second) }
      Then { context.should have_received(:invoked).with("OTHER", :first, :second) }
      Then { result == [:first, :second] }
    end

    describe "calling unknown" do
      When(:result) { runner.callback(:unknown, :first, :second) }
      Then { context.should_not have_received(:invoked) }
      Then { result == [:first, :second] }
    end

    describe '#current_user' do
      Given(:user) { double('User') }
      Given(:context) { double(current_user: user)}
      Then { runner.current_user == user }
    end

    describe '#services' do
      Given(:services) { double('Services') }
      Given(:context) { double(services: services)}
      Then { runner.services == services }
    end
  end
end