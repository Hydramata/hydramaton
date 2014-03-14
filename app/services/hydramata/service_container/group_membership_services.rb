module Hydramata::ServiceContainer
  module GroupMembershipServices
    def add_member_to_group(collaborators = {})
      group = collaborators.fetch(:group)
      person = collaborators.fetch(:person)
      predicate = collaborators.fetch(:predicate) { :is_member_of }
      authority = collaborators.fetch(:authority) { Hydramata.system_authority }
      Hydramata::Core::Relationship.create(subject: person, predicate: predicate, target: group, authority: authority)
    end
  end
end