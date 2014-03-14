# Responsible for the transformation logic. That is to say, the methods
# responsible for marshalling up an object from persistance, dumping objects to
# their persistence layer.
#
#
module Hydramata
  class Services
    include ServiceContainer::GroupServices
    include ServiceContainer::GroupMembershipServices
  end
end
