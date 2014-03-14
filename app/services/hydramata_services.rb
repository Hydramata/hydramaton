# Responsible for the transformation logic. That is to say, the methods
# responsible for marshalling up an object from persistance, dumping objects to
# their persistence layer.
#
#
class HydramataServices
  def new_group_for(creator, attributes = {})
    group = Hydramata::Group.new_form_for(creator)
    group.attributes = attributes if attributes.present?
    group
  end

  def edit_group_for(user, group_id, attributes = {})
    group = Hydramata::Group.existing_form_for(user, group_id)
    group.attributes = attributes if attributes.present?
    group
  end

  def save_group(group, collaborators = {})
    creators = Array.wrap(collaborators.fetch(:creators))
    transaction do
      group.save &&
      creators.all? {|creator|
        create_relationship(
          subject: creator,
          predicate: 'is_creator_of',
          target: group.group,
          creator: creator
        )
      }
    end
  end

  def find_group(group_id)
    Hydramata::Group.find(group_id)
  end

  def create_relationship(attributes = {})
    Hydramata::Core::Relationship.create(attributes)
  end

  private
  def transaction
    returning_value = true
    ActiveRecord::Base.transaction do
      if ! yield
        returning_value = false
        raise ActiveRecord::Rollback
      end
    end
    returning_value
  end
end
