require 'spec_helper'

describe HydramataServices do
  Given(:services) { HydramataServices.new }
  Given(:user) { FactoryGirl.build_stubbed(:user) }
  Given(:attributes) { {name: 'Name'} }

  context '#new_group_for' do
    When(:result) { services.new_group_for(user, attributes) }
    Then { expect(result.creator).to eq(user) }
    And { expect(result.name).to eq(attributes.fetch(:name)) }
    And { expect(result.class.model_name).to eq(Hydramata::Group.model_name) }
  end

  context '#save_group' do
    Given(:user) { FactoryGirl.create(:user) }
    Given(:group) { services.new_group_for(user, attributes) }
    context 'valid save' do
      When(:result) { services.save_group(group, creators: user) }
      Then { expect(group).to be_persisted }
      And { expect(group.group.creators).to eq([user]) }
    end

    context 'invalid save' do
      Given(:attributes) { { name: nil } }
      When(:result) { services.save_group(group, creators: user) }
      Then { expect(group.group).to_not be_persisted }
      And { expect(group.group.creators).to eq([]) }
    end
  end
end