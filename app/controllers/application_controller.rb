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

  # So you can specify where you will be finding an action's Runner class.
  class_attribute :runner_container

  # So you can more easily decouple the controller's command behavior and
  # response behavior.
  #
  # @Example
  #   def index
  #     run(specific_params) do |on|
  #       on.success { |collection|
  #         @collection = collection
  #         respond_with(@collection)
  #       }
  #     end
  #   end
  #
  # @See Hydramata::Runner for more information about runners
  # @See .runner_container
  def run(*args, &block)
    runner_name = action_name.classify
    if runner_container.const_defined?(runner_name)
      runner = runner_container.const_get(runner_name)
      runner.run(self, *args, &block)
    else
      raise Hydramata::RunnerNotFoundError.new(runner_container, runner_name)
    end
  end

  # So you can easily invoke the public services of Hydramata.
  # It is these services that indicate what the application can and is doing.
  def services
    @services ||= Hydramata::Services.new
  end
  helper_method :services
end
