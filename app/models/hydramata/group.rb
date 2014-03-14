module Hydramata
  class Group < ActiveRecord::Base
    self.table_name = 'hydramata_groups'

    def creators
      Core::Relationship.subjects_for(predicate: :is_creator_of, target: self)
    end

    def self.new_form_for(user)
      group = Group.new
      Form.new(group: group, creator: user)
    end

    def self.existing_form_for(user, identifier)
      group = Group.find(identifier)
      Form.new(group: group)
    end

  end
end
