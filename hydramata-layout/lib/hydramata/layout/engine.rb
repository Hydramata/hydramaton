module Hydramata
  module Layout
    class Engine < ::Rails::Engine
      isolate_namespace Hydramata::Layout
      engine_name 'hydramata_layout'
    end
  end
end
