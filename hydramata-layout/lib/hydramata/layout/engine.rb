module Hydramata
  module Layout
    class Engine < ::Rails::Engine
      isolate_namespace Hydramata::Layout
      engine_name 'hydramata_layout'

      initializer 'hydramata-layout.initializers' do |app|
        require 'bootstrap-datepicker-rails'
      end

    end
  end
end
