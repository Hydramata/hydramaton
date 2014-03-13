require 'spec_helper'

describe HydramataServices do
  Given(:services) { HydramataServices.new }

  context '#new_group_for' do
    Given(:user) { FactoryGirl.build_stubbed(:user) }
    Given(:attributes) { {name: 'Name'} }
    When(:result) { services.new_group_for(user, attributes) }
    Then { expect(result.creator).to eq(user) }
    And { expect(result.name).to eq(attributes.fetch(:name)) }
    And { expect(result.class.model_name).to eq(Hydramata::Group.model_name) }
  end

  context '#save' do
    Given(:group) { double('Group', save: true) }
    When(:result) { services.save_group(group) }
    Then { expect(group).to have_received(:save) }
  end
end