require 'hydramata/configuration'

module Hydramata
  module Core
  end

  class << self
    attr_accessor :configuration
  end

  module_function
  def configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def config
    configuration
  end
end

require "hydramata/core/engine"
require 'hydramata/core/works_responder'
