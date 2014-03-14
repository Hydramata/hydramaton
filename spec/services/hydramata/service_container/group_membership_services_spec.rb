require 'spec_helper'

module Hydramata::ServiceContainer
  class GroupMembershipServiceContainer
    include GroupMembershipServices
  end

  describe GroupMembershipServices do
    Given(:group) { FactoryGirl.build_stubbed(:hydramata_group) }
    Given(:user) { FactoryGirl.create(:user) }
    Given(:creator) { double('Creator', id: '123') }
    Given(:services) { GroupMembershipServiceContainer.new }

    context '#add_member_to_group' do
      When(:result) { services.add_member_to_group(group: group, person: user, predicate: 'is_member_of', creator: creator) }
      Then { expect(group.members).to eq([user]) }
      And { expect(result).to be_an_instance_of(Hydramata::Core::Relationship) }
    end

  end
end
