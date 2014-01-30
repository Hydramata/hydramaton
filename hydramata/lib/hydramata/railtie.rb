module Hydramata
  class Railtie < Rails::Railtie
    # Likely we will want to lock the configuration after Rails has
    # had a chance to do all the initialization.
  end
end