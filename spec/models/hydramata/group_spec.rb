require 'spec_helper'

module Hydramata
  describe Group do
    Given(:group) { Group.new }

    context '.new_form_for' do
      Given(:user) { double('Context') }
      Given(:name) { 'my name'}
      When(:result) { Group.new_form_for(user) }
      Then { expect(result.creator).to eq(user) }
      And { expect(result.group).to be_an_instance_of(Group) }
    end

    context '.existing_form_for' do
      before(:each) do
        Group.should_receive(:find).with(identifier).and_return(group)
      end
      Given(:group) { double('Group', persisted?: true) }
      Given(:user) { double('Context') }
      Given(:identifier) { '123' }
      When(:result) { Group.existing_form_for(user, identifier) }
      Then { expect(result.group).to eq(group) }
    end

    context '#creators' do
      When(:result) { group.creators }
      Then { expect(result).to be_an(Enumerable)}
    end

    context '#members' do
      When(:result) { group.members }
      Then { expect(result).to be_an(Enumerable)}
    end

  end

end
