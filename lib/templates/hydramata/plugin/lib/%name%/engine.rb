module Hydramata
  module <%= without_name_space.camelcase %>
    class Engine < ::Rails::Engine
      isolate_namespace <%= camelized %>
      engine_name '<%= original_name.underscore %>'
    end
  end
end
