require 'spec_helper'
module Hydramata
  describe Group::Form do

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
