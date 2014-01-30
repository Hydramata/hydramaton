module Hydramata::Core

  class Engine < ::Rails::Engine

    isolate_namespace Hydramata::Core
    engine_name 'hydramata_core'

    initializer 'hydramata-core.initializers' do |app|
      app.config.paths.add 'app/services', eager_load: true
      app.config.autoload_paths += %W(
        #{config.root}/app/services
      )
    end

    # From api.rubyonrails.org
    #
    # Last configurable block to run. Called after frameworks initialize.
    config.after_initialize do
      Hydramata.configure {|config| config.lock! }
    end

  end
end
