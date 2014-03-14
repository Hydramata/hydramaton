module Hydramata
  class RunnerNotFoundError < RuntimeError
    def initialize(runner_container, runner_name)
      super("Unable to find #{runner_name} in #{runner_container}")
    end
  end
end

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class_attribute :theme
  self.theme = Hydramata.configuration.layout.theme
  helper_method :theme

  class_attribute :runner_container
  def run(*args, &block)
    runner_name = action_name.classify
    if runner_container.const_defined?(runner_name)
      runner = runner_container.const_get(runner_name)
      runner.run(self, *args, &block)
    else
      raise Hydramata::RunnerNotFoundError.new(runner_container, runner_name)
    end
  end

  def services
    @services ||= HydramataServices.new
  end
end
