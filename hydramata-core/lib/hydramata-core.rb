require 'hydramata/configuration'
require 'paperclip'

module Hydramata
  module Core
  end

  # Configuration is shared across the Hydramata namespace;
  # Hydramata.configuration
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
