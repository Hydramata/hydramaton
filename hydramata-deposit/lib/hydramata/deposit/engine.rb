require 'virtus'
require File.expand_path('../../../../app/models/hydramata/contributor', __FILE__)

module Hydramata::Deposit

  class Engine < ::Rails::Engine

    isolate_namespace Hydramata::Deposit
    engine_name 'hydramata_deposit'

    initializer 'hydramata-deposit.initializers' do |app|
      require 'simple_form'
      app.config.paths.add 'app/finalizers', eager_load: true
      app.config.paths.add 'app/forms', eager_load: true
      app.config.paths.add 'app/resolvers', eager_load: true
      app.config.paths.add 'app/inputs', eager_load: true
      app.config.paths.add 'app/services', eager_load: true
      app.config.autoload_paths += %W(
        #{config.root}/app/finalizers
        #{config.root}/app/forms
        #{config.root}/app/inputs
        #{config.root}/app/resolvers
        #{config.root}/app/services
      )
    end
  end
end
