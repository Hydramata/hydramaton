require 'spec_helper'

describe Hydramata::Group do
  Given(:group) { Hydramata::Group.new }

end

describe Hydramata::Group::Form do
  Given(:group) { Hydramata::Group.new }
  Given(:attributes) { { group: group} }
  Given(:form) { Hydramata::Group::Form.new(attributes) }

  context 'attributes' do
    Then { expect(form.group).to eq(group) }
  end

  context '#save' do
    Given(:group) { double('Group', :save => true, :attributes= => true) }
    Given(:form) { Hydramata::Group::Form.new(group: group, name: 'my name') }
    When(:save_result) { form.save }
    Then { expect(save_result).to eq true }
    And { expect(group).to have_received(:attributes=).with(name: 'my name') }
    And { expect(group).to have_received(:save) }
  end

  context '#update' do
    Given(:group) { double('Group', :update => true) }
    Given(:form) { Hydramata::Group::Form.new(group: group) }
    Given(:attributes) { { name: 'my name' } }
    When(:update_result) { form.update(attributes) }
    Then { expect(update_result).to eq true }
    And { expect(form.attributes).to eq(attributes.merge(group: group)) }
    And { expect(group).to have_received(:update).with(name: 'my name') }
  end

  context '.model_name' do
    Given(:form_class) { described_class }
    Then { expect(form_class.model_name).to eq(Hydramata::Group.model_name) }
  end

end
