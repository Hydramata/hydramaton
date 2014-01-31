module Hydramata::Core
  module NoidMintingService
    module_function
    def call(*args)
      "sufia:#{rand(100000000000000)}"
    end
  end
end