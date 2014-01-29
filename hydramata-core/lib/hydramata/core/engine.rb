require 'hydramata/core/configuration'
require 'virtus'

module Hydramata::Core

  class Engine < ::Rails::Engine

    def initialize(*args)
      super
      @config = Hydramata::Core::Configuration.new(find_root_with_flag("lib"))
    end

    isolate_namespace Hydramata::Core
    engine_name 'hydramata_core'

    initializer 'hydramata-core.initializers' do |app|
      app.config.paths.add 'app/finalizers', eager_load: true
      app.config.paths.add 'app/forms', eager_load: true
      app.config.paths.add 'app/resolvers', eager_load: true
      app.config.paths.add 'app/services', eager_load: true
      app.config.autoload_paths += %W(
        #{config.root}/app/finalizers
        #{config.root}/app/forms
        #{config.root}/app/resolvers
        #{config.root}/app/services
      )
    end

  end
end
