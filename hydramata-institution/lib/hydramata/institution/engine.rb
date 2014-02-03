module Hydramata
  module Institution
    class Engine < ::Rails::Engine
      isolate_namespace Hydramata::Institution
      engine_name 'hydramata_institution'
    end
  end
end
