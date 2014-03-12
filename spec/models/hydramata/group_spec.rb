require 'spec_helper'

module Hydramata
  describe Group do
    Given(:group) { Group.new }

    context '.new_form_for' do
      Given(:user) { double('Context') }
      Given(:name) { 'my name'}
      When(:result) { Group.new_form_for(user) }
      Then { expect(result).to be_an_instance_of(Group::Form) }
      And { expect(result.creator).to eq(user) }
    end
  end

  describe Group::Form do
    Given(:group) { Group.new }
    Given(:attributes) { { group: group} }
    Given(:form) { Group::Form.new(attributes) }

    context 'attributes' do
      Then { expect(form.group).to eq(group) }
    end

    context '#save' do
      Given(:group) { double('Group', persisted?: false, :save => true, :attributes= => true) }
      Given(:creator) { double('Creator') }
      Given(:form) { Group::Form.new(group: group, creator: creator, name: 'my name') }
      When(:save_result) { form.save }
      Then { expect(save_result).to eq true }
      And { expect(group).to have_received(:attributes=).with(name: 'my name') }
      And { expect(group).to have_received(:save) }
    end

    context '#update' do
      Given(:group) { double('Group', persisted?: true, :update => true) }
      Given(:form) { Group::Form.new(group: group) }
      Given(:attributes) { { name: 'my name' } }
      When(:update_result) { form.update(attributes) }
      Then { expect(update_result).to eq true }
      And { expect(form.attributes).to eq(attributes) }
      And { expect(group).to have_received(:update).with(name: 'my name') }
    end

    context '.model_name' do
      Given(:form_class) { described_class }
      Then { expect(form_class.model_name).to eq(Group.model_name) }
    end

  end
end
