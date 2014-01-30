require 'hydramata/configuration'
require 'hydramata/railtie' if defined?(Rails)

module Hydramata
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
