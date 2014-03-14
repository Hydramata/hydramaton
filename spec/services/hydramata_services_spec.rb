require 'spec_helper'

describe HydramataServices do
  Given(:services) { HydramataServices.new }
  Given(:user) { FactoryGirl.build_stubbed(:user) }
  Given(:attributes) { {name: 'Name'} }

  context '#find_group' do
    Given!(:group) { FactoryGirl.create(:hydramata_group) }
    When(:result) { services.find_group(group.id) }
    Then { expect(result).to eq(group) }
  end

  context '#new_group_for' do
    When(:result) { services.new_group_for(user, attributes) }
    Then { expect(result.creator).to eq(user) }
    And { expect(result.name).to eq(attributes.fetch(:name)) }
    And { expect(result.class.model_name).to eq(Hydramata::Group.model_name) }
  end

  context '#edit_group_for' do
    Given!(:group) { FactoryGirl.create(:hydramata_group) }
    Given(:attributes) { {name: 'Hello World'} }
    When(:result) { services.edit_group_for(user, group.id, attributes) }
    Then { expect(result.group).to eq(group) }
    And { expect(result.name).to eq(attributes.fetch(:name)) }
    And { expect(result.class.model_name).to eq(Hydramata::Group.model_name) }
  end

  context '#create_relationship' do
    Given(:creator) { double('Creator', id: '123' ) }
    Given(:subject) { double('Subject', id: '456' ) }
    Given(:target) { double('Target', id: '789' ) }
    Given(:predicate) { 'is_member_of' }
    Given(:attributes) {
      { predicate: predicate, creator: creator, subject: subject, target: target }
    }
    When(:result) { services.create_relationship(attributes) }
    Then { expect(result).to be_persisted }
    And { expect(result).to be_an_instance_of(Hydramata::Core::Relationship) }

  end

  context '#save_group' do
    Given(:user) { FactoryGirl.create(:user) }
    Given(:group) { services.new_group_for(user, attributes) }
    context 'valid save' do
      When(:result) { services.save_group(group, creators: user) }
      Then { expect(result).to eq true }
      And { expect(group).to be_persisted }
      And { expect(group.group.creators).to eq([user]) }
    end

    context 'invalid save' do
      Given(:attributes) { { name: nil } }
      When(:result) { services.save_group(group, creators: user) }
      Then { expect(result).to eq false }
      And { expect(group.group).to_not be_persisted }
      And { expect(group.group.creators).to eq([]) }
    end
  end
end
