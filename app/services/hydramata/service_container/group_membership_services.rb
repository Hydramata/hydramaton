module Hydramata::ServiceContainer
  module GroupMembershipServices
    def add_member_to_group(collaborators = {})
      group = collaborators.fetch(:group)
      person = collaborators.fetch(:person)
      predicate = collaborators.fetch(:predicate) { :is_member_of }
      authority = collaborators.fetch(:authority)
      Hydramata::Core::Relationship.create(subject: person, predicate: predicate, target: group, authority: authority)
    end

    def remove_member_from_group(collaborators = {})
      group = collaborators.fetch(:group)
      person = collaborators.fetch(:person)
      predicate = collaborators.fetch(:predicate) { :is_member_of }
      Hydramata::Core::Relationship.query(subject: person, predicate: predicate, target: group).destroy_all
    end
  end
end