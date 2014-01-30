require 'configatron'
module Hydramata
  # It is my intention that the configuration has top-level keys that have a
  # corresponding plugin. That is to say configurations for Hydramata::Deposit
  # would have a corresponding Hydramata.configuration.deposit entry.
  #
  # That said, I'm not entirely certain how things will need to be configured.
  # So if you introduce something to the configuration make sure that you are
  # writing tests.
  class Configuration < ::Configatron::Store
  end
end