module Hydramata::ServiceContainer
  module GroupMembershipServices
    def add_member_to_group(collaborators = {})
      group = collaborators.fetch(:group)
      person = collaborators.fetch(:person)
      predicate = collaborators.fetch(:predicate) { :is_member_of }
      creator = collaborators.fetch(:creator) { Hydramata.system_authority }
      Hydramata::Core::Relationship.create(subject: person, predicate: predicate, target: group, creator: creator)
    end
  end
end