class HydramataServices
  def new_group_for(creator, attributes = {})
    group = Hydramata::Group.new_form_for(creator)
    group.attributes = attributes if attributes.present?
    group
  end

  def save_group(group)
    group.save
  end
end
