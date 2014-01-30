require 'hydramata/core/configuration'

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

  end
end
