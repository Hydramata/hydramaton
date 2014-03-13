class HydramataServices
  def new_group_for(creator, attributes = {})
    group = Hydramata::Group.new_form_for(creator)
    group.attributes = attributes if attributes.present?
    group
  end

  def save_group(group, collaborators = {})
    creators = Array(collaborators.fetch(:creators)).flatten.compact
    group.save
    creators.all? do |creator|
      Hydramata::Core::Relationship.create(
        subject: creator,
        predicate: 'is_creator_of',
        target: group.group,
        creator: creator
      )
    end
  end
end
